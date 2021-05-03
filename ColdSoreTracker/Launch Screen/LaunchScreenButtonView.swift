//
//  LaunchScreenButtonView.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 5/4/21.
//

import SwiftUI

struct LaunchScreenButtonView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var selection: Int
    
    @State var selectedReason: String = "Unknown"
    @State var lastSore: Date = Date()
    @State var name : String = ""
    
    
    
    
    var body: some View {
        
        if (selection < 5 && selection >= 0){
            
            Button(action: {buttonAction()},
                
                label: {
                Text("Continue").fontWeight(.heavy).padding().frame(width: 150, height: 44).background(Color.black.opacity(0.27)).cornerRadius(12).padding(.horizontal).foregroundColor(.white)
                })
            
        } else if (selection == 5){
            
            Button(action: {StartTracking()},
                label: {
                    
                Text("Start Tracking").fontWeight(.heavy).padding().frame(width: 200, height: 44).background(Color.black.opacity(0.27)).cornerRadius(12).padding(.horizontal).foregroundColor(.white)
            })
            
        }
        
    }
    
   func buttonAction(){
   
       withAnimation{
            
            if (selection < 5){
                selection += 1
            }

        }
    
    }
    
    func StartTracking(){
        withAnimation{

            saveDidLaunchBefore()
            
            viewRouter.currentPage = .home
            
        }
    }
    
    func saveDidLaunchBefore(){
        UserDefaults.standard.set(true, forKey: "didLaunchBefore")
        
        
    }
    
}





struct LaunchScreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenButtonView(selection: Binding.constant(0))
    }
}
