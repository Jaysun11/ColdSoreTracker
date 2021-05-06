//
//  Calendar.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 22/4/21.
//

import ElegantCalendar
import SwiftUI


struct ColdSoreCalendar: View, /*Equatable,*/ ElegantCalendarDelegate, ElegantCalendarDataSource {
    
    @ObservedObject private var calendarManager: ElegantCalendarManager

    let coldSoresByDay: [Date: [ColdSore]]
   
    
    @State private var calendarTheme: CalendarTheme = CalendarTheme(primary: Color(#colorLiteral(red: 0, green: 0.9658375382, blue: 0.7308886647, alpha: 1)))

    init(coldsores: [ColdSore]) {
        
        
        let sortedsores = coldSoreObjects.sorted(by: { $0.date < $1.date })
        var startDate : Date
        var endDate : Date
        var initMonth : Date
        
        if (sortedsores.count >= 1){
            startDate = sortedsores[0].date
            initMonth = sortedsores[0].date
            
            if (sortedsores.count == 1){
                endDate = startDate
            } else {
                endDate = sortedsores[sortedsores.count-1].date
                initMonth = sortedsores[sortedsores.count-1].date
            }
            
            endDate = endDate.addingTimeInterval(TimeInterval(60 * 60 * 24 * (1 * 36)))
            startDate = startDate.addingTimeInterval(TimeInterval(60 * 60 * 24 * (-1 * 36)))
            
        } else {
            startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-2 * 36)))
            endDate = Date()
            initMonth = Date()
        }
        
        if (endDate > Date()){
            endDate = Date()
        }

        let configuration = CalendarConfiguration(
            calendar: currentCalendar,
            startDate: startDate,
            endDate: endDate)

        calendarManager = ElegantCalendarManager(
            configuration: configuration, initialMonth: initMonth)

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
    
   /* static func == (lhs: Self, rhs: Self) -> Bool {
        return (lhs.coldSoresByDay as NSDictionary).isEqual(to: rhs.coldSoresByDay)
      
    }
    */
  
    
}





extension ColdSoreCalendar {

    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
       let startOfDay = currentCalendar.startOfDay(for: date)
        //Gets a day
        return Double((coldSoresByDay[startOfDay]?.count ?? 0))
    }

    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
       let startOfDay = currentCalendar.startOfDay(for: date)
        return CalendarElement(coldSoresByDay: coldSoresByDay[startOfDay] ?? []).erased
    }
    
    
}



struct ColdSoreCalendar_Previews: PreviewProvider {
    static var previews: some View {
        let coldsores = [ColdSore(date: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * ( -3 * 36))), reason: reasons[4]), ColdSore(date: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * ( -1 * 36))), reason: reasons[2])]
        ColdSoreCalendar(coldsores: coldsores)
    }
}
