//
//  Insights.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 6/4/21.
//

import SwiftUI

struct Insights: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
       
        
        VStack(){
            if (numSores == 0){
                Text("Track your first sore to display insights")
            } else {
                TypesOfSoresChart()
            }
            
        
            Button(action: {reset()},
                label: {
                Text("Reset").fontWeight(.heavy).padding().frame(width: 200, height: 44).background(Color.black.opacity(0.27)).cornerRadius(12).padding(.horizontal).foregroundColor(.white)
            })
            
           
            
        }
    }
    
    func reset(){
        
        withAnimation{
            //Check if the values have been entered on this
            //Uncomment this
            UserDefaults.standard.set(false, forKey: "didLaunchBefore")
            viewRouter.currentPage = .onboarding
            
        }
        
    }
    
    
}


struct Insights_Previews: PreviewProvider {
    static var previews: some View {
        Insights()
    }
}
