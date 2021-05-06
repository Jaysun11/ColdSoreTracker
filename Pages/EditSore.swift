//
//  EditSore.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 25/4/21.
//

import SwiftUI



struct EditBody: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selectedReason: String = "Unknown"
    @State private var newSoreDate: Date = Date()
    @State private var newSoreDuration: Int = 0
    @State private var newSoreLocation: String = "Unknown"
    
    
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
                            Text("Edit Date").font(.body).foregroundColor(.black).opacity(0.6)
                            
                            DatePicker("", selection: $newSoreDate, in: ...Date(), displayedComponents: .date).foregroundColor(.gray).onChange(of: newSoreDate, perform: { value in
                                //soreEditing.date = newSoreDate
                            }).accentColor(Color.black.opacity(0.6)).frame(width: 130, height: 35, alignment: .center).labelsHidden()
                            Spacer()
                        }.frame(width: 130, height: 80)
                        VStack{
                            Spacer()
                            Text("Edit Cause").font(.body).foregroundColor(.black).opacity(0.6)
                            
                            
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
                            Text("Update Cold Sore Location").font(.body).foregroundColor(.black).opacity(0.6)
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
                    
                    
                    
                    Button(action: {updatebuttonAction(date: newSoreDate, reason: selectedReason)},
                           
                           label: {
                            Text("Confirm Update").fontWeight(.heavy).padding().frame(width: 180, height: 44).background(Color(#colorLiteral(red: 0, green: 1, blue: 0.8056185842, alpha: 1)).opacity(0.5)).cornerRadius(12).padding(.horizontal).foregroundColor(.white)
                           }).padding(.top, 10)
                    Spacer()
                    
                    
                }.padding(.top, 20)
            }.frame(width: geometry.size.width, height: 370, alignment: .top)
            
            Banner().position(x: geometry.size.width/2, y: geometry.size.height-25)
            
        }.onAppear(){
            selectedReason = soreEditing.reason
            newSoreDate = soreEditing.date
            newSoreDuration = soreEditing.duration ?? 0
            newSoreLocation = soreEditing.location ?? "Unknown"
        }
    }
    
    func updateColdSore(date: Date,reason: String){
        var newSore: ColdSore
        if (newSoreDuration != 0){
            newSore = ColdSore(date: date, reason: reason, duration: newSoreDuration, location: newSoreLocation)
        }else {
            newSore = ColdSore(date: date, reason: reason, location: newSoreLocation)
        }
        
        
        newSore.colorindex = soreEditing.colorindex
        
        coldSoreObjects.removeAll(where: {
            $0.id == soreEditing.id
            
        })
        
        coldSoreObjects.append(newSore)
        
        
        //Storing Items
        if let encoded = try? JSONEncoder().encode(coldSoreObjects) {
            UserDefaults.standard.set(encoded, forKey: "coldSoreObjects")
        }
        
        
        indexOfMostRecentSore = findIndexOfMostRecentSore()
        
        
        
    }
    
    func updatebuttonAction(date: Date,reason: String){
        
        //Save Cold Sore
        updateColdSore(date: date, reason: reason)
        getNumUniques()
        getNumLocations()
        
        withAnimation(){
            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
            impactHeavy.impactOccurred()
            viewRouter.currentPage = .calendar
            
        }
        
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
    
    
}




struct EditSore: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var showingCancelAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .leading){
                ZStack{
                    Image(systemName: "chevron.left").resizable()
                        .aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center).position(x:25, y:30).foregroundColor(.black).opacity(0.6).onTapGesture(perform: {
                            showingCancelAlert = true
                        }).alert(isPresented:$showingCancelAlert) {
                            Alert(
                                title: Text("Cancel Update"),
                                message: Text("\nAre you sure you want to cancel this change?"),
                                primaryButton: .destructive(Text("Delete Changes")) {
                                    print("Cancelling Update...")
                                    withAnimation{
                                        viewRouter.currentPage = .home
                                        showingCancelAlert = false
                                    }
                                    
                                },
                                secondaryButton: .cancel(){}
                                
                            )
                        }
                    
                    Text("Update Cold Sore").font(.title).foregroundColor(.black).opacity(0.6)
                    
                }.frame(height: 60)
                
                
                
                
                EditBody().padding(.top, 0)
            }
        }
        
    }
}

struct EditSore_Previews: PreviewProvider {
    static var previews: some View {
        EditSore()
    }
}
