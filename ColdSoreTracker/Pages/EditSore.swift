//
//  EditSore.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 25/4/21.
//

import SwiftUI

struct EditSore: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    let coldsore : ColdSore = soreEditing
    
    
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .leading){
                ZStack{
                    Image(systemName: "chevron.left").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center).position(x:25, y:30).foregroundColor(.gray).opacity(0.7).onTapGesture(perform: {
                            withAnimation{
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                                viewRouter.currentPage = .home
                                
                            }
                        })
                    
                    Image("Logo").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 60, height: 60, alignment: .center).clipShape(Circle())
                    
                    
                }.frame(height: 60)
                
                
                Text("Edit Coldsore").font(.largeTitle/*@END_MENU_TOKEN@*/).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding([.top, .leading]).padding(/*@START_MENU_TOKEN@*/.top)
            }
        }
        
    }
}

struct EditSore_Previews: PreviewProvider {
    static var previews: some View {
        EditSore()
    }
}
