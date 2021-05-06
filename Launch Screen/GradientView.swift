//
//  GradientView.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 5/4/21.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 1, blue: 0.4155218899, alpha: 1)), Color(#colorLiteral(red: 0, green: 1, blue: 0.8078195453, alpha: 1)), Color(#colorLiteral(red: 0.616707027, green: 1, blue: 0.9674422145, alpha: 1))]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
