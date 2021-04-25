//
//  Calendar.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 22/4/21.
//

import ElegantCalendar
import SwiftUI


struct ColdSoreCalendar: View, Equatable, ElegantCalendarDelegate, ElegantCalendarDataSource {
    
    @ObservedObject private var calendarManager: ElegantCalendarManager

    

    let coldSoresByDay: [Date: [ColdSore]]

    
    @State private var calendarTheme: CalendarTheme = CalendarTheme(primary: Color(#colorLiteral(red: 0, green: 0.9658375382, blue: 0.7308886647, alpha: 1)))

    init(coldsores: [ColdSore]) {
        
        
        let startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-24 * 36)))
        let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (0 * 36)))
        
        let configuration = CalendarConfiguration(
            calendar: currentCalendar,
            startDate: startDate,
            endDate: endDate)

        calendarManager = ElegantCalendarManager(
            configuration: configuration,
            initialMonth: Date())

        coldSoresByDay = Dictionary(grouping: coldsores, by: { currentCalendar.startOfDay(for: $0.date) })

        calendarManager.datasource = self
        calendarManager.delegate = self
    }

    var body: some View {
        ZStack {
            ElegantCalendarView(calendarManager: calendarManager)
                .theme(calendarTheme)
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.coldSoresByDay as NSDictionary).isEqual(to: rhs.coldSoresByDay)
      
    }
    
    
}



extension ColdSoreCalendar {

    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
       let startOfDay = currentCalendar.startOfDay(for: date)
        //Gets a day
        return Double((coldSoresByDay[startOfDay]?.count ?? 0))
    }

    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
       let startOfDay = currentCalendar.startOfDay(for: date)
       return CalendarElement(coldsores: coldSoresByDay[startOfDay] ?? []).erased
    }
    
    
}



struct ColdSoreCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let coldsores = [ColdSore(date: Date(), reason: reasons[4]), ColdSore(date: Date(), reason: reasons[2])]
        ColdSoreCalendar(coldsores: coldsores)
    }
}
