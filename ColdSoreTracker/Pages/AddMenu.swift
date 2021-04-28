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
    @State private var showingCancelAlert = false
    
    
    var body: some View {
        GeometryReader { g in
        
        VStack{
            ZStack{
                Image(systemName: "chevron.left").resizable()
                    .aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center).position(x:25, y:30).foregroundColor(.black).opacity(0.5).onTapGesture(perform: {
                        withAnimation{
                            showingCancelAlert = true
                            
                            
                        }
                    }).alert(isPresented:$showingCancelAlert) {
                        Alert(
                            title: Text("Cancel New Sore"),
                            message: Text("\nAre you sure you want to cancel this new sore?"),
                            primaryButton: .destructive(Text("Delete Changes")) {
                                print("Cancelling New...")
                                withAnimation{
                                    viewRouter.currentPage = .home
                                    showingCancelAlert = true
                                }
                                
                            },
                            secondaryButton: .cancel(){}
                            
                        )
                    }
                Text("Track New Cold Sore").font(.title).foregroundColor(.black).opacity(0.6)
                
            }.frame(height:60)
            
            
            AddMenuContent().padding(.top, 20)
            
           
        }
            Banner().position(x: g.size.width/2, y: g.size.height-25)
        }
        
    }
    
    
    
}




struct AddMenu_Previews: PreviewProvider {
    static var previews: some View {
        AddMenu().environmentObject(ViewRouter())
    }
}
