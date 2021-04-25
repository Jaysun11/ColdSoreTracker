//
//  CalendarElement.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 23/4/21.
//

import SwiftUI
import Swift


struct CalendarElement: View {
    let coldSoresByDay: [ColdSore]
    
    
    init(coldsores: [ColdSore]){
        coldSoresByDay = coldsores
    }
    
    var body: some View {
        coldsoresList
            .animation(.easeInOut)
    }
    
    
    var coldsoresList: some View {
        
        
        GeometryReader { g in
            
            List {
                
                ForEach(0..<coldSoresByDay.count) { index in
                    if (index <= 3){
                        
                        ColdsoreCell(coldsore: coldSoresByDay[index], color: chartColours[index])
                        
                    }
                    
                }.onDelete(perform: delete)
            }.frame(width: g.size.width-10, height: g.size.height/1.5, alignment: .leading).padding(.leading, -20)
            
        }
            
        }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { (i) in
            
            coldSoreObjects.removeAll(where: {
                $0.id == coldSoresByDay[i].id
                
            })
            UserDefaults.standard.set(coldSoreObjects, forKey: "coldSoreObjects")
            numSores -= 1
            numDifferentSores -= 1
            UserDefaults.standard.set(numSores, forKey: "numSores")
            UserDefaults.standard.set(numDifferentSores, forKey: "numUniqueSores")
            //coldSoresByDay.remove(at: i)
        }
    }

        
        
        
    }
    
    struct CalendarElement_Previews: PreviewProvider {
        
        
        static var previews: some View {
            let coldsores = [ColdSore(date: Date(), reason: reasons[4]), ColdSore(date: Date(), reason: reasons[2])]
            CalendarElement(coldsores: coldsores)
        }
    }
