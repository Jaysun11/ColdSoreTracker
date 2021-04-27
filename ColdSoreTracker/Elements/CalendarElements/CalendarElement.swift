//
//  CalendarElement.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 23/4/21.
//

import SwiftUI
import Swift


struct CalendarElement: View {
    @State var coldSoresByDay: [ColdSore]
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var isEditing = false
    
    
    var body: some View {
        coldsoresList
            .animation(.easeInOut).onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
                
            }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var coldsoresList: some View {
        
        GeometryReader { g in
        
        List{
            ForEach(coldSoresByDay, id: \.id) { coldsore in
                ZStack{
                    HStack {
                        
                        HStack{
                            
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 5, height: 40, alignment: .leading).foregroundColor(chartColours[coldsore.colorindex])
                            VStack(alignment: .leading){
                                Text("Reason: \(coldsore.reason)")
                                    .padding(.horizontal)
                                Text((dateFormatter.string(from: coldsore.getDate())))
                                    .font(.system(size: 16))
                                    .lineLimit(1).padding(.horizontal)
                            }
                        }
                        
                        Spacer()
                        
                        
                    }.frame(height: 40)
                    .padding(.vertical, 10).contextMenu {
                        Button {
                            print("Edit ColdSore Selected")
                            editPushed(coldsore: coldsore)
                        } label: {
                            Label("Edit Cold Sore", systemImage: "pencil.circle")
                        }
                        
                        Button {
                            delete(coldsore: coldsore)
                            print("Delete Cold Sore Selected")
                        } label: {
                            Label("Delete Cold Sore", systemImage: "trash.circle")
                        }
                    }
                    
                }
                
            }
            
            
        }
        .padding(.trailing, 5.0).offset(x: -20, y:0).frame(height: g.size.height/1.4)
        }
    }
    
    func delete(coldsore: ColdSore) {
        withAnimation{
            viewRouter.currentPage = .calendar
        }
        
        coldSoreObjects.removeAll(where: {
                                    $0.id == coldsore.id})
        
        
        if let encoded = try? JSONEncoder().encode(coldSoreObjects) {
            UserDefaults.standard.set(encoded, forKey: "coldSoreObjects")
        }
        numSores -= 1
        
        if (numSores > 0){
            indexOfMostRecentSore = findIndexOfMostRecentSore()
        }
        
        UserDefaults.standard.set(numSores, forKey: "numSores")
        getNumUniques()
        
        coldSoresByDay.removeAll(where: {
                                    $0.id == coldsore.id})
        
        
        
        
    }
    

    func findIndexOfMostRecentSore() -> Int{
        //current smallest index
        var index = 0;
        var lastSore = coldSoreObjects[0]
        var smallestIndex = 0;
        
        for sore in coldSoreObjects {
            if (lastSore.getDate() <= sore.getDate()){
                lastSore = sore;
                smallestIndex = index
            }
            index = index + 1
        }
        return smallestIndex;
    }
    
    func getNumUniques(){
        
        let mappedItems = coldSoreObjects.map { ($0.reason, 1) }
        let _counts = Dictionary(mappedItems, uniquingKeysWith: +)
        var index = 0
        
        
        for reason in reasons {
            if _counts[reason] != nil {
                
                index+=1
                
            } else {
                
            }
        }
        
        numDifferentSores = index;
        
        UserDefaults.standard.set(numDifferentSores, forKey: "numUniqueSores")
    }
    
    
    func editPushed(coldsore: ColdSore){
        viewRouter.currentPage = .change
        soreEditing = coldsore
        
        
    }
    
    
    
}

struct CalendarElement_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let coldsores = [ColdSore(date: Date(), reason: reasons[4]), ColdSore(date: Date(), reason: reasons[2])]
        CalendarElement(coldSoresByDay: coldsores)
    }
}






/*//GeometryReader { g in
 
 
 List{
 ForEach(coldSoresByDay, id: \.id) { coldsore in
 ZStack{
 ColdsoreCell(coldsore: coldsore, color: chartColours[coldsore.colorindex])
 }
 
 }
 
 }.offset(x: -10, y:0)
 
 }
 
 
 // }*/
