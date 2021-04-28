//
//  HomePage.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 4/4/21.
//

import SwiftUI
import StoreKit

struct HomePage: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    private var name : String = "Unknown"
    
    
    var body: some View {
        
        
        GeometryReader { geometry in
            let geowidth = geometry.size.width
            let size : CGFloat = CGFloat(330 + (numDifferentSores * 40))
            
            ScrollView{
               
                VStack(alignment: .leading) {
                    
                    
                    VStack(alignment: .leading){
                        HStack{
                            HStack{
                                Text("Hey")
                                    .font(.largeTitle).fontWeight(.bold).foregroundColor(.black).opacity(0.6)
                                Text("\(UserDefaults.standard.string(forKey: "name") ?? "Name")")
                                    .font(.largeTitle).bold().foregroundColor(Color(#colorLiteral(red: 0, green: 1, blue: 0.8056185842, alpha: 1)))
                            }
                            Spacer()
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geowidth/11 , height: geowidth/11).offset(x: -20).foregroundColor(Color.gray).shadow(color: .black, radius: 0).onTapGesture {
                                    withAnimation {
                                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                        impactHeavy.impactOccurred()
                                        
                    
                                        viewRouter.currentPage = .settings
                                        
                                    }
                                }
                        }
                        
                    }
                    .padding()

                    
                    LastColdSore().frame(width: geometry.size.width, height: 170)
                    
                    Text("Your Insights")
                        .font(.title3).fontWeight(.bold).foregroundColor(.black).opacity(0.6).padding().padding(.top, 5)
                    

                    Insights().frame(height: size)
                    
                    
                    
                    Rectangle().frame(height: geometry.size.height/10).cornerRadius(15).padding().foregroundColor(.white).opacity(0)
                    
                    
                }.frame(width: geowidth)
                    
                        
                
            }.frame(height: geometry.size.height)
            
            Banner().position(x: geometry.size.width/2, y: geometry.size.height-25)
        }
        
        .onAppear(){
            loadData()
        }
        
    }
    func runReview(){
        if #available(iOS 14.0, *) {
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            } else {
                SKStoreReviewController.requestReview()
            }
    }
    
    func checkforReview(){
        var reviewCheck = UserDefaults.standard.integer(forKey: "reviewCheck")
        if (reviewCheck == 10){
            runReview()
            reviewCheck = 0
            UserDefaults.standard.set(reviewCheck, forKey: "reviewCheck")
        } else {
            reviewCheck += 1
            UserDefaults.standard.set(reviewCheck, forKey: "reviewCheck")
        }
    }
    
    func loadData(){
        paddingAmountForMenuBar = 50
        numSores = UserDefaults.standard.integer(forKey: "numSores")
        print("Home Page: There is currently: \(numSores) sores in the system, unique: \(numDifferentSores)")
        
        checkforReview()
        
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

