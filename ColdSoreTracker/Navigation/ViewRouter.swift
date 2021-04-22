//
//  ViewRouter.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 3/4/21.
//

import SwiftUI

enum Page {
     case home
     case calendar
     case add
     case onboarding
     case launch
 }

class ViewRouter: ObservableObject {
   
    init() {
            if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
                
                currentPage = Page.onboarding
            } else {
                currentPage =  Page.launch
            }
        }
    
    @Published var currentPage: Page
    
}
