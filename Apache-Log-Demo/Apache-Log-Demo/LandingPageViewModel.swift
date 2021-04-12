//
//  LandingPageViewModel.swift
//  Apache-Log-Demo
//
//  Created by Matthew Kaulfers on 4/12/21.
//

import Foundation

class LandingPageViewModel: ObservableObject {
    @Published var eventLogs = [EventLog]()
    @Published var activeSheet: ActiveSheet?
    private let logURL = "https://files.inspiringapps.com/IAChallenge/30E02AAA-B947-4D4B-8FB6-9C57C43872A9/Apache.log"
    
    func fetchRemoteData() {
        activeSheet = .loading
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent("logfile.log")
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: logURL)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    DispatchQueue.main.async {
                        self.activeSheet = .error
                    }
                }
                
            } else {
                self.activeSheet = nil
                if let error = error {
                    print("Error took place while downloading a file. Error description: \(error.localizedDescription)");
                } else {
                    print("Cannot retrieve error description. Unknown error occured.")
                }
                self.activeSheet = .error
            }
            DispatchQueue.main.async {
                self.activeSheet = nil
            }
            self.parseData()
        }
        task.resume()
    }
    
    func parseData() {
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent("logfile.log")
        
        do {
            let contents = try String(contentsOf: destinationFileUrl, encoding: .utf8)
            let lines = contents.split(separator: "\n")
            let pattern = "^((?:\\d+\\.){3,}\\d).*?\\[([^]]*)\\].*?\"([^\"]*)\"\\s*(\\d+)\\s+(\\d+)\\s*\"-\"\\s*\"([^\"]*)\"$"
            for line in lines {
                let group = String(line).groups(for: pattern)
                let subGroup = group[0]
                let ipAddress = subGroup[1]
                let date = subGroup[2]
                let getMethod = subGroup[3]
                let statusCode = subGroup[4]
                let secondStatusCode = subGroup[5]
                let versionInfo = subGroup[6]
                
                DispatchQueue.main.async {
                    self.eventLogs.append(EventLog(ipAddress: ipAddress, date: date, getMethod: getMethod, statusCode: statusCode, secondStatusCode: secondStatusCode, versionInfo: versionInfo))
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    enum ActiveSheet: Identifiable {
        case loading, error, finished
        
        var id: Int {
            hashValue
        }
    }
}

extension String {
    func groups(for regexPattern: String) -> [[String]] {
        do {
            let text = self
            let regex = try NSRegularExpression(pattern: regexPattern)
            let matches = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return matches.map { match in
                return (0..<match.numberOfRanges).map {
                    let rangeBounds = match.range(at: $0)
                    guard let range = Range(rangeBounds, in: text) else {
                        return ""
                    }
                    return String(text[range])
                }
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
