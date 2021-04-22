//
//  HomePage.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 4/4/21.
//

import SwiftUI

struct HomePage: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
     private var name : String = "Unknown"
    
    
    var body: some View {
        
        
        GeometryReader { geometry in
            let geowidth = geometry.size.width
            
            ScrollView{
                
                
                VStack(alignment: .leading) {
                    
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Hey")
                                .font(.largeTitle).bold()
                            Text("\(UserDefaults.standard.string(forKey: "name") ?? "Name")")
                                .font(.largeTitle).bold().foregroundColor(Color(#colorLiteral(red: 0, green: 1, blue: 0.8056185842, alpha: 1)))
                        }
                        
                        Text("Cold Sore Tracker")
                            .font(.title3).bold().padding(.bottom, 10).padding(.top, 5)
                        
                        
                    }
                    .padding()
                    
                    
                    ZStack(){
                        
                        Rectangle().frame(height: geometry.size.height/5).cornerRadius(15).padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                        
                        LastColdSore()
                        
                    }
                    
                    Text("Your Insights")
                        .font(.title3).bold().padding().padding(.top, 5)
                    
                    ZStack(){
                        
                        Rectangle().frame(height: (geometry.size.height/2.4 + CGFloat(numDifferentSores*65))).cornerRadius(15).padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                        
                        Insights()
                        
                    }
                    
                    Rectangle().frame(height: geometry.size.height/10).cornerRadius(15).padding().foregroundColor(.white)
                    
                    
                }.frame(width: geowidth)
                
            }.frame(height: geometry.size.height)
            
            
        }
        
        .onAppear(){
            loadData()
        }
        
    }
    
    func loadData(){
        numSores = UserDefaults.standard.integer(forKey: "numSores")
        print("Home Page: There is currently: \(numSores) sores in the system, unique: \(numDifferentSores)")
        
       
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



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomePage().environmentObject(ViewRouter())
        }
    }
}

