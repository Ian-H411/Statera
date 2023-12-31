//
//  StateraApp.swift
//  Statera
//
//  Created by Ian Hall on 10/29/23.
//

import SwiftUI
import FirebaseCore
import SwiftyDropbox

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private var apiKey: String {
        get {
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
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        DropboxClientsManager.setupWithAppKey(apiKey)
        return true
    }
}

@main
struct StateraApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
