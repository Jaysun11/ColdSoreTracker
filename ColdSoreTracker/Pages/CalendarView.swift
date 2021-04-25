//
//  CalendarView.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 4/4/21.
//

import SwiftUI

let currentCalendar = Calendar.current
let screen = UIScreen.main.bounds

struct CalendarView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter

    
    var body: some View {
       
        
       
        ColdSoreCalendar(coldsores: coldSoreObjects)
            
        
        
        
    }
}



struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(ViewRouter())
    }
}
