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
    @State private var newSoreLocation: String = "Unknown"
    let colour = 0
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                Rectangle().cornerRadius(15).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white).padding(.horizontal).frame(width:screen.size.width)
                VStack(alignment: .center){
                    
                    ZStack{
                        Rectangle().fill(Color.black.opacity(0.1)).cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/).frame(width: 260, height: 60, alignment: .center)
                        
                        cellSore
                        
                    }.frame(width: 260, height: 60, alignment: .center)
                    
                    //Top Row------------------------
                    
                    HStack{
                        VStack{
                            Spacer()
                            Text("Cold Sore Date").font(.body).foregroundColor(.black).opacity(0.6)
                            
                            DatePicker("", selection: $newSoreDate, in: ...Date(), displayedComponents: .date).foregroundColor(.gray).onChange(of: newSoreDate, perform: { value in
                                //soreEditing.date = newSoreDate
                            }).accentColor(Color.black.opacity(0.6)).frame(width: 130, height: 35, alignment: .center).labelsHidden()
                            Spacer()
                        }.frame(width: 130, height: 80)
                        VStack{
                            Spacer()
                            Text("Cold Sore Cause").font(.body).foregroundColor(.black).opacity(0.6)
                            
                            
                            ZStack{
                                Rectangle().fill(Color.black.opacity(0.07)).cornerRadius(7).frame(width: 130, height: 35)
                                Picker(selectedReason, selection: $selectedReason, content: {
                                    ForEach(reasons, id: \.self, content: { reason in
                                        Text(reason)
                                    })
                                }).foregroundColor(Color.black.opacity(0.6)).onChange(of: selectedReason, perform: { value in
                                    
                                }).pickerStyle(MenuPickerStyle()).accentColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/).frame(width: 120, height: 35)
                            }
                            Spacer()
                        }.frame(width: 130, height: 80)
                    }.frame(width: 300, height: 80).padding(.top, 10)
                    
                    //Top Row------------------------
                    //Middle Row -------------------
                    VStack{
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
                            }).foregroundColor(Color.black.opacity(0.6)).onChange(of: selectedReason, perform: { value in
                                
                            }).pickerStyle(MenuPickerStyle()).accentColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/).frame(width: 220, height: 35)
                        }
                    }.frame(width: 300, height: 80).padding(.top, 10)
                    //Middle Row -----------------------------
                    
                    
                    //Bottom Row -------------------
                    VStack{
                        HStack{
                            Text("Cold Sore Location").font(.body).foregroundColor(.black).opacity(0.6)
                            Text("optional").font(.caption).fontWeight(.thin).foregroundColor(.black).opacity(0.6)
                        }
                        
                        ZStack{
                            Rectangle().fill(Color.black.opacity(0.07)).cornerRadius(7).frame(width: 220, height: 35)
                            Picker(newSoreLocation, selection: $newSoreLocation, content: {
                                ForEach(locations, id: \.self, content: { location in
                                    Text(location)
                                })
                            }).foregroundColor(Color.black.opacity(0.6)).onChange(of: newSoreLocation, perform: { value in
                                
                            }).pickerStyle(MenuPickerStyle()).accentColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/).frame(width: 220, height: 35)
                        }
                    }.frame(width: 300, height: 80).padding(.top, 10)
                    //Bottom Row -----------------------------
                    
                    
                    
                    
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
        
        
        HStack{
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 5, height: 50, alignment: .leading).foregroundColor(chartColours[soreEditing.colorindex])
            
            
            
            ZStack{
                
                VStack(alignment: .leading){
                    
                    HStack(alignment: .center, spacing: 0){
                        Text("Cause: ")
                        Text("\(selectedReason)").lineLimit(1).minimumScaleFactor(0.2)
                    }
                    
                    
                    VStack(alignment: .leading){
                        Text("Duration: \(newSoreDuration) days").font(.system(size: 11)).fontWeight(.light)
                        Text("Location: \(newSoreLocation)")
                            .font(.system(size: 11)).fontWeight(.light)
                    }.padding(.top, -6)
                        
                    
        
                }.frame(width: 210,height: 50, alignment: .leading).padding(.leading, 5)
                
                
                
                
            }
            
            
        }.frame(width: 250,height: 60)
        
        
    }
    
    
    func buttonAction(date: Date,reason: String){
        
        //Save Cold Sore
        saveColdSore(date: date, reason: reason)
        getNumUniques()
        getNumLocations()
        
        withAnimation(){
            
            viewRouter.currentPage = .home
        }
        
    }
    
    func saveColdSore(date: Date,reason: String){
        
        if (newSoreDuration == 0){
            let newSore = ColdSore(date: date, reason: reason, duration: nil, location: newSoreLocation)
            coldSoreObjects.append(newSore)
        } else {
            let newSore = ColdSore(date: date, reason: reason, duration: newSoreDuration, location: newSoreLocation)
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
    
    func getNumLocations(){
        
        let mappedItems = coldSoreObjects.map { ($0.location, 1) }
        let _counts = Dictionary(mappedItems, uniquingKeysWith: +)
        var index = 0
        
        
        for location in locations {
            if _counts[location] != nil {
                
                index+=1
                
            } else {
                
            }
        }
        
        numdifferentLocations = index;
        
        UserDefaults.standard.set(numdifferentLocations, forKey: "numUniqueLocations")
    }
    
    
    
}






struct AddMenuContent_Previews: PreviewProvider {
    static var previews: some View {
        AddMenuContent()
    }
}
