//
//  CalendarView.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 4/4/21.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
       
        GeometryReader { geometry in
            VStack(alignment: .leading){
                Text("Your Cold Sores").font(.title).bold().padding()
                ZStack(){
                    
                    Rectangle().frame(height: geometry.size.height/1.32).cornerRadius(15).padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    
                    
                }
            }
        }
        
        
    }
}



struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(ViewRouter())
    }
}
