//
//  Insights.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 6/4/21.
//

import SwiftUI

struct Insights: View {
    @EnvironmentObject var viewRouter: ViewRouter
    let size : CGFloat = CGFloat(330 + (numDifferentSores * 40))
    
    var body: some View {
        GeometryReader { geometry in
            
           
            ZStack{
                Rectangle().frame(height: size).cornerRadius(15).padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                
                    if (numSores == 0){
                        Text("Track your first sore to display insights").foregroundColor(.black).opacity(0.6).frame(width: screen.size.width-30)
                    } else {
                        TypesOfSoresChart()
                    }
                    
                    
                
            }
        }.frame(height: size)
    }
    
    
    
    
}


struct Insights_Previews: PreviewProvider {
    static var previews: some View {
        Insights()
    }
}
