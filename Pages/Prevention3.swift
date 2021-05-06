//
//  Prevention3.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 1/5/21.
//

import SwiftUI

struct Prevention3: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
            Text("Cold Sore Prevention").font(.title2).fontWeight(.semibold).foregroundColor(.black).opacity(0.6).multilineTextAlignment(.leading)
                Text("Cont.").font(.caption2).fontWeight(.light).foregroundColor(.black).opacity(0.6).multilineTextAlignment(.leading).padding(.bottom, 3)
            }.padding(.top, 10.0)
            HStack(alignment: .top){
                Circle().frame(width: 5, height: 5).foregroundColor(.black).opacity(0.6).padding(.top, 6)
                Text("Avoid sharing toiletries, towels, cutlery or any objects potentially in contact with an active sore" ).font(.subheadline).foregroundColor(.black).opacity(0.6)
            }.padding(.top)
            
           
            HStack(alignment: .top){
                Circle().frame(width: 5, height: 5).foregroundColor(.black).opacity(0.6).padding(.top, 6)
                Text("When a sore is active, avoid touching it and wash your hands often. This can help keep you from spreading the virus to your eyes, genital area or to others.").font(.subheadline).foregroundColor(.black).opacity(0.6)
            }.padding(.top)
            
            Spacer()
            HStack(alignment: .center){
                Text("Swipe for more informaton" ).foregroundColor(.black).opacity(0.6)
                Image(systemName: "arrow.right").foregroundColor(.black).opacity(0.6)
            }.padding(.top)
            Spacer()
            
            Text("This information does not replace the advice of a doctor. Cold Sore Tracker holds no liability for your use of this information." ).font(.caption2).fontWeight(.light).foregroundColor(.black).multilineTextAlignment(.leading).opacity(0.6)
            
            Spacer()
        }.frame(width:280, height: 330)
    }
}

struct Prevention3_Previews: PreviewProvider {
    static var previews: some View {
        Prevention3()
    }
}
