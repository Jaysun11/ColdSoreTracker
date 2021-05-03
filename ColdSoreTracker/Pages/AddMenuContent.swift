//
//  AddMenuContent.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 12/4/21.
//

import SwiftUI

struct AddMenuContent: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selectedReason: String = "Unknown"
    @State private var newSoreDate: Date = Date()
    @State private var newSoreDuration: Int = 0
    let colour = 0
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                Rectangle().cornerRadius(15).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white).padding(.horizontal).frame(width:screen.size.width)
                VStack(alignment: .center){
                    
                    ZStack{
                        
                        Rectangle().fill(Color.black.opacity(0.2)).cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        cellSore.padding(.leading, 10)
                        
                    }.frame(width: geometry.size.width/1.5, height: 50, alignment: .center)
                    
                    Text("New Coldsore Date").font(.body).foregroundColor(.black).opacity(0.6).padding(.top, 30)
                    
                    DatePicker("", selection: $newSoreDate, in: ...Date(), displayedComponents: .date).foregroundColor(.gray).onChange(of: newSoreDate, perform: { value in
                        //soreEditing.date = newSoreDate
                    }).accentColor(Color.black.opacity(0.6)).frame(width: 120, height: 35, alignment: .center).padding(.bottom).labelsHidden()
                    
                    
                    Text("New Cold Sore Cause").font(.body).foregroundColor(.black).opacity(0.6)
             
                    
                    ZStack{
                        Rectangle().fill(Color.black.opacity(0.07)).cornerRadius(7).frame(width: 220, height: 35)
                        Picker(selectedReason, selection: $selectedReason, content: {
                            ForEach(reasons, id: \.self, content: { reason in
                                Text(reason)
                            })
                        }).padding(.vertical, 20).foregroundColor(Color.black.opacity(0.6)).onChange(of: selectedReason, perform: { value in
                            
                        }).pickerStyle(MenuPickerStyle()).accentColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/).frame(width: 220)
                    }
                    
                    HStack{
                        Text("Duration (time to heal)").font(.body).foregroundColor(.black).opacity(0.6)
                        Text("optional").font(.caption).fontWeight(.thin).foregroundColor(.black).opacity(0.6)
                    }
                    
                    ZStack{
                        Rectangle().fill(Color.black.opacity(0.07)).cornerRadius(7).frame(width: 220, height: 35)
                        Picker("\(newSoreDuration) days", selection: $newSoreDuration, content: {
                            ForEach(1...14, id:\.self){ i in
                                                Text("\(i) days")
                                            }
                        }).padding(.vertical, 20).foregroundColor(Color.black.opacity(0.6)).onChange(of: selectedReason, perform: { value in
                            
                        }).pickerStyle(MenuPickerStyle()).accentColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/).frame(width: 220)
                    }
                    
                    
                    
                    
                    Button(action: {buttonAction(date: newSoreDate, reason: selectedReason)},
                           
                           label: {
                            Text("Add Cold Sore").fontWeight(.heavy).padding().frame(width: 180, height: 44).background(Color(#colorLiteral(red: 0, green: 1, blue: 0.8056185842, alpha: 1)).opacity(0.5)).cornerRadius(12).padding(.horizontal).foregroundColor(.white)
                           }).padding(.top, 10)
                    Spacer()
                    
                    
                }.padding(.top, 20)
            }.frame(width: geometry.size.width, height: 370, alignment: .top)
        }
        
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    
    var cellSore: some View {
        
        HStack {
            
            HStack{
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 5, height: 40, alignment: .leading).foregroundColor(chartColours[colour])
                VStack(alignment: .leading){
                    Text("Reason: \(selectedReason)")
                        .padding(.horizontal)
                    
                    
                    HStack(alignment: .bottom){
                        Text((dateFormatter.string(from: newSoreDate)))
                            .font(.system(size: 16))
                            .lineLimit(1).padding(.horizontal)
                        Text("Duration: \(newSoreDuration) days")
                            .font(.caption2).padding(.bottom, 2).padding(.leading, -10)
                    }
                }
            }
            
            Spacer()
            
            
        }.frame(height: 40)
        .padding(.vertical, 10)
        
    }
    
    
    func buttonAction(date: Date,reason: String){
        
        //Save Cold Sore
        saveColdSore(date: date, reason: reason)
        getNumUniques()
        
        withAnimation(){
            
            viewRouter.currentPage = .home
        }
        
    }
    
    func saveColdSore(date: Date,reason: String){
        
        if (newSoreDuration == 0){
            let newSore = ColdSore(date: date, reason: reason, duration: nil)
            coldSoreObjects.append(newSore)
        } else {
            let newSore = ColdSore(date: date, reason: reason, duration: newSoreDuration)
            coldSoreObjects.append(newSore)
        }
        
        
        
        
        
        //Storing Items
        if let encoded = try? JSONEncoder().encode(coldSoreObjects) {
            UserDefaults.standard.set(encoded, forKey: "coldSoreObjects")
        }
        
        numSores = numSores + 1
        
        UserDefaults.standard.set(numSores, forKey: "numSores")
        
        indexOfMostRecentSore = findIndexOfMostRecentSore()
        
        
        
        
        
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
    
    
    
}


/*
 
 
 
 
 
 
 ZStack(){
 Rectangle().cornerRadius(15).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white).padding().frame(width:screen.size.width)
 GeometryReader { g in
 VStack(alignment: .center){
 
 Text("When was this cold sore?").font(.title2).foregroundColor(.black).opacity(0.6)
 
 DatePicker("", selection: $newSoreDate, in: ...Date(), displayedComponents: .date).frame(width: 330) .datePickerStyle(WheelDatePickerStyle())
 
 
 Text("What caused it?").font(.title2).foregroundColor(.black).opacity(0.6)
 
 Picker("Select an option", selection: $selectedReason, content: {
 ForEach(reasons, id: \.self, content: { reason in
 Text(reason)
 .foregroundColor(.black).opacity(0.6)
 })
 }).padding(.top, -30).frame(width: screen.size.width-30)
 
 Button(action: {buttonAction(date: newSoreDate, reason: selectedReason)},
 
 label: {
 Text("Add").fontWeight(.heavy).padding().frame(width: 100, height: 44).background(Color(#colorLiteral(red: 0, green: 1, blue: 0.8056185842, alpha: 1)).opacity(0.57)).cornerRadius(12).foregroundColor(.white)
 })
 
 }.padding(.top).padding(.top)
 
 }
 }
 */








struct AddMenuContent_Previews: PreviewProvider {
    static var previews: some View {
        AddMenuContent()
    }
}
