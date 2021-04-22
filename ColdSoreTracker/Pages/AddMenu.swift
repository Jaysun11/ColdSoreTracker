//
//  AddMenu.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 4/4/21.
//

import SwiftUI

struct AddMenu: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selectedReason: String = "Unknown"
    @State private var newSoreDate: Date = Date()
    
    var body: some View {
        
        
        GeometryReader { geometry in
            VStack(alignment: .leading){
                Text("Track New Cold Sore").font(.title).bold().padding()
                ZStack(){
                    
                    Rectangle().frame(height: geometry.size.height/1.32).cornerRadius(15).padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white).padding(.top, -120)
                        
                        AddMenuContent()
                    
                    
                }
            }
        }
        
        
    }
    
    
}




struct AddMenu_Previews: PreviewProvider {
    static var previews: some View {
        AddMenu().environmentObject(ViewRouter())
    }
}
