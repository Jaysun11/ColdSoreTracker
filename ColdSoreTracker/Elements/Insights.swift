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
             
            
        }
    }
    
    
    
    
}


struct Insights_Previews: PreviewProvider {
    static var previews: some View {
        Insights()
    }
}
