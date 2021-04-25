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
     case settings
    case changeName
    case aboutUs
    case privacypolicy
    case change
    
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
