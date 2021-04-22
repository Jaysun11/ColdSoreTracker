//
//  Launch Screen.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 12/4/21.
//

import SwiftUI

struct Launch_Screen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack(){
            GradientView()
            VStack(){
                Image("LogoTrans").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.bottom, -25.0)
                Text("Cold Sore Tracker").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().multilineTextAlignment(.center).foregroundColor(.white)
            }.padding()
        
        }.onAppear(){
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                loadData()
            }
            
            
        }
      
    }
    
    func loadData(){
        numSores = UserDefaults.standard.integer(forKey: "numSores")
        print("Launch Load: There is currently: \(numSores) sores in the system")
        numDifferentSores = UserDefaults.standard.integer(forKey: "numUniqueSores")
        print("Launch Load: There is currently: \(numDifferentSores) unique sores in the system")
       
        //Retrieving Items
        
        if (numSores > 0){
        do {
            let storedObjItem = UserDefaults.standard.object(forKey: "coldSoreObjects")
            let objects = try JSONDecoder().decode([ColdSore].self, from: storedObjItem as! Data)
            coldSoreObjects = objects
            print("Retrieved items: \(coldSoreObjects)")
            indexOfMostRecentSore = findIndexOfMostRecentSore()
        } catch let err {
            print(err)
        }
        }
        
        
        
        
        
        withAnimation(){
            
            viewRouter.currentPage = .home
        }
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



struct Launch_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Launch_Screen()
    }
}
