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
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        DropboxClientsManager.setupWithAppKey("1yjjrtncuw7wytd")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let oauthCompletion: DropboxOAuthCompletion = {
          if let authResult = $0 {
              switch authResult {
              case .success:
                  print("Success! User is logged into DropboxClientsManager.")
              case .cancel:
                  print("Authorization flow was manually canceled by user!")
              case .error(_, let description):
                  print("Error: \(String(describing: description))")
              }
          }
        }
        let canHandleUrl = DropboxClientsManager.handleRedirectURL(url, includeBackgroundClient: false, completion: oauthCompletion)
        return canHandleUrl
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
