//
//  ProfileSetup.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 5/4/21.
//

import SwiftUI

struct ProfileSetup: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selection = 0
    
    
    var body: some View {
        ZStack(){
            GradientView()
         
            VStack(){
                PageTabView(selection: $selection)
                LaunchScreenButtonView(selection: $selection)
                
            }
            
            
        }.transition(.scale)


}
}

struct ProfileSetup_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetup().environmentObject(ViewRouter())
    }
}
