//
//  Prevention4.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 1/5/21.
//

import SwiftUI

struct Prevention4: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .bottom){
            Text("Seek Medical Help").font(.title2).fontWeight(.semibold).foregroundColor(.black).opacity(0.6).multilineTextAlignment(.leading)
             
            }.padding(.top, 10.0)
            
            HStack(alignment: .top){
                Text("There are a number of over the counter treatments (patches, creams) that expedite the healing process. If this is not successful: " ).font(.subheadline).foregroundColor(.black).opacity(0.6)
            }.padding(.top)
            
            HStack(alignment: .top){
                Text("Seek medical assistance from your doctor, particularly if you are getting cold sores often. Qualified professionals may be able to prescribe treatments to assist in decreasing future outbreaks." ).font(.subheadline).foregroundColor(.black).opacity(0.6)
            }.padding(.top)
            
            
        Spacer()

            Text("Cold Sore Tracker" ).font(.caption2).fontWeight(.light).foregroundColor(.black).multilineTextAlignment(.leading).opacity(0.6)
            Spacer()
            
        }.frame(width:280, height: 330)
    }
}

struct Prevention4_Previews: PreviewProvider {
    static var previews: some View {
        Prevention4()
    }
}
