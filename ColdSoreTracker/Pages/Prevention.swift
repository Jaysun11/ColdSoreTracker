//
//  Prevention.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 1/5/21.
//

import SwiftUI

struct Prevention: View {
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Cold Sores (HSV-1)").font(.title).fontWeight(.semibold).foregroundColor(.black).opacity(0.6).multilineTextAlignment(.leading).padding(.top, 10.0)
            HStack{
                Text("After you have been infected with the virus, unfortunately there is no certain way to prevent future outbreaks. There are however, some things you can do to reduce outbreaks and prevent spreading the virus." ).foregroundColor(.black).opacity(0.6).padding(.top)
            }
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

struct Prevention_Previews: PreviewProvider {
    static var previews: some View {
        Prevention()
    }
}
