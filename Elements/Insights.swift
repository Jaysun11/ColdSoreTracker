//
//  Insights.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 6/4/21.
//


import SwiftUI

struct InsightsView: View {

    var body: some View {
        ZStack{
            if (numSores == 0){
                Text("Track your first sore to display insights").foregroundColor(.black).opacity(0.6).frame(width: screen.size.width-30)
            } else {
                VStack{
                    Text("Your Cold Sore Causes").font(.title).foregroundColor(.black).opacity(0.6).padding(.bottom, 10)
                    TypesOfSoresChart()
                }
            }
        }
    }
}

struct Insights: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @Binding var selection: Int
    
   

    var body: some View {
            
            ZStack{
                
                TabView(selection: $selection) {
                    InsightsView().tag(0)
                    
                    
                    AverageHealingTime().tag(1)
                    
                    LocationView().tag(2)
                    
                    AverageHealingTimeLocation().tag(3)
                    
                }.tabViewStyle(PageTabViewStyle()).indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                
            }.frame(height: height)
        }
    
    
    
}


struct Insights_Previews: PreviewProvider {
    static var previews: some View {
        Insights(selection: Binding.constant(2))
    }
}



