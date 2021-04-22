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
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            
            VStack(alignment: .center){
                
                Text("When was this cold sore?").font(.title2).padding(.top, 50)
                
                DatePicker("", selection: $newSoreDate, displayedComponents: .date).frame(width: 330) .datePickerStyle(WheelDatePickerStyle()).foregroundColor(.black)
                
                Text("What caused it?").font(.title2)
                
                Picker("Select an option", selection: $selectedReason, content: {
                    ForEach(reasons, id: \.self, content: { reason in
                        Text(reason)
                            .foregroundColor(.black)
                    })
                }).padding(.top, -30)
                
                Button(action: {buttonAction(date: newSoreDate, reason: selectedReason)},
                       
                       label: {
                        Text("Add").fontWeight(.heavy).padding().frame(width: 150, height: 44).background(Color(#colorLiteral(red: 0, green: 1, blue: 0.8056185842, alpha: 1)).opacity(0.57)).cornerRadius(12).padding(.horizontal).foregroundColor(.white)
                       })
                
                
            }.frame(width: geometry.size.width, height: geometry.size.height/1.32)
            
            
        }
    }
    
    func buttonAction(date: Date,reason: String){
        
        //Save Cold Sore
        saveColdSore(date: date, reason: reason)
        
        
        withAnimation(){
            
            viewRouter.currentPage = .home
        }
        
    }
    
    func saveColdSore(date: Date,reason: String){
        
        let newSore = ColdSore(date: date, reason: reason)
        
        coldSoreObjects.append(newSore)
    
        
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
    
}



struct AddMenuContent_Previews: PreviewProvider {
    static var previews: some View {
        AddMenuContent()
    }
}
