//
//  Preventions.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 2/5/21.
//

import SwiftUI

struct Preventions: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @Binding var selection: Int
    
    var body: some View {
        ZStack{
            
            TabView(selection: $selection) {
               
                Prevention().padding(.bottom, 20).tag(0)//.padding(.bottom, CGFloat(numDifferentSores * 35))
               
                Prevention2().padding(.bottom, 20).tag(1)//.padding(.bottom, CGFloat(numDifferentSores * 35))
                
                Prevention3().padding(.bottom, 20).tag(2)//.padding(.bottom, CGFloat(numDifferentSores * 35))
                
                Prevention4().padding(.bottom, 20).tag(3)//.padding(.bottom, CGFloat(numDifferentSores * 35))
                
            }.tabViewStyle(PageTabViewStyle()).indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            
        }.frame(height: 390)
    }
}

struct Preventions_Previews: PreviewProvider {
    static var previews: some View {
        Preventions(selection: Binding.constant(2))
    }
}
