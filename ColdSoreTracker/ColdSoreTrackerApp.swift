//
//  ColdSoreTrackerApp.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 3/4/21.
//

import SwiftUI

//TESTING SAVING COLD SORES

extension UserDefaults {
  func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
    let encoded = try? JSONEncoder().encode(data)
    set(encoded, forKey: defaultName)
  }
}
//TESTING SAVIGN COLDSORES

@main
struct ColdSoreTrackerApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}
