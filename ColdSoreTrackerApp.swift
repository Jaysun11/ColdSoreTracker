//
//  ColdSoreTrackerApp.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 3/4/21.
//

import SwiftUI
import GoogleMobileAds

//TESTING SAVING COLD SORES

extension UserDefaults {
  func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
    let encoded = try? JSONEncoder().encode(data)
    set(encoded, forKey: defaultName)
  }
}
//TESTING SAVIGN COLDSORES


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["e0870ec51287042f9f77d4aa4bc3481b" ]
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}

@main
struct ColdSoreTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}
