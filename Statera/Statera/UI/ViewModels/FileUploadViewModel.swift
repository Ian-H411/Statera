//
//  FileUploadViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/31/23.
//

import Foundation
import SwiftyDropbox
import UIKit

class FileUploadViewModel: ObservableObject {
    
    let client: DropboxClient
    
    init() {
        self.client = DropboxClient(accessToken: FileUploadViewModel.getApiKey())
    }
    
    private static func getApiKey() -> String {
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let xml = FileManager.default.contents(atPath: filePath) else {
            print("error loading plist, does it exist?")
            return ""
        }
        do {
            let plistData = try PropertyListSerialization.propertyList(from: xml, options: .mutableContainers, format: nil)
            if let plistDict = plistData as? [String: Any],
               let apiKey = plistDict["API_KEY"] as? String {
                return apiKey
            }
        } catch {
            print ("Error reading: \(error.localizedDescription)")
        }
        return ""
    }
    
    func upload(data: Data) {
        
        let request = client.files.upload(path: "/test", input: data)
            .response { response, error in
                    if let response = response {
                        print(response)
                    } else if let error = error {
                        print(error)
                    }
                }
            .progress { progressData in
                print(progressData)
            }
    }
    
    func login() {
        let scopeRequest = ScopeRequest(scopeType: .user, scopes: ["account_info.read"], includeGrantedScopes: false)
        DropboxClientsManager.authorizeFromControllerV2(
            UIApplication.shared,
            controller: nil,
            loadingStatusDelegate: nil,
            openURL: { (url: URL) -> Void in UIApplication.shared.open(url, options: [:], completionHandler: nil) },
            scopeRequest: scopeRequest
        )
    }
}
