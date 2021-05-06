//
//  Settings.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 22/4/21.
//

import SwiftUI


struct buttonView : View{
    let systemIconName, tabName: String, width: CGFloat
    
    
    
    var body: some View {
    
        
        HStack(alignment: .center) {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40).foregroundColor(.black).opacity(0.6)
            
            ZStack{
            Rectangle().opacity(0).frame(width: width/1.4, height: 50, alignment: .leading).contentShape(Rectangle())
            Text(tabName)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black).opacity(0.6)
                .padding(.leading, 5.0)
                .frame(width: width/1.4, height: 50, alignment: .leading)
            }
            
            
            Image(systemName: "chevron.right")
                .padding(.trailing, 10.0).foregroundColor(.black).opacity(0.6)
               
        }
        .padding(.leading, 10.0).frame(width: screen.size.width-30)
        
       
    }
    
}

struct Settings: View {
    
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        
        GeometryReader { geometry in
                
            let width = geometry.size.width
            
        ZStack{
                Image(systemName: "chevron.left").resizable()
                    .aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center).position(x:25, y:30).foregroundColor(.black).opacity(0.5).onTapGesture(perform: {
                        withAnimation{
                            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                        impactHeavy.impactOccurred()
                            viewRouter.currentPage = .home
                            
                        }
                    })
                
                Image("Logo").resizable()
                    .aspectRatio(contentMode: .fit).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
            }.frame(height: 60)
            
            
            
            
        VStack(alignment: .leading){
            
            Text("Settings").font(.largeTitle).fontWeight(.semibold).foregroundColor(.black).opacity(0.6).padding(.top, 60.0).padding(/*@START_MENU_TOKEN@*/.leading, 10.0/*@END_MENU_TOKEN@*/)
            
            buttonView(systemIconName: "person", tabName: "Update Name", width: width).padding(.top, 10.0).onTapGesture(perform: {
                withAnimation{
                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                    viewRouter.currentPage = .changeName}
            
            })
            

            buttonView(systemIconName: "questionmark.circle", tabName: "About Us", width: width).onTapGesture(perform: {
                withAnimation{
                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                viewRouter.currentPage = .aboutUs
                }
            })
            
            buttonView(systemIconName: "calendar.badge.minus", tabName: "Clear Cold Sores", width: width).onTapGesture(perform: {
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                showingAlert = true
            }).alert(isPresented:$showingAlert) {
                Alert(
                    title: Text("Delete Cold Sores?"),
                    message: Text("\nThere is no way to undo this action"),
                    primaryButton: .destructive(Text("Reset")) {
                        print("Resetting...")
                        
                        reset()
                    },
                    secondaryButton: .cancel(){}
           
                )
            }
    
            
            buttonView(systemIconName: "trash", tabName: "Factory Reset", width: width).onTapGesture(perform: {
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                showingAlert2 = true
            }).alert(isPresented:$showingAlert2) {
                Alert(
                    title: Text("Reset All App Data?"),
                    message: Text("\nThere is no way to undo this action"),
                    primaryButton: .destructive(Text("Reset")) {
                        print("Resetting...")
                        
                        factoryReset()
                    },
                    secondaryButton: .cancel(){}
           
                )
            }
            
            
            
        }.padding(.all).lineSpacing(15)
            Banner().position(x: geometry.size.width/2, y: geometry.size.height-25)
            
            
        }
        
    }
    
    
    func reset(){
        
        withAnimation{
            //Check if the values have been entered on this
            //Uncomment this
            
            indexOfMostRecentSore = 0
            numSores = 0
            coldSoreObjects = [ColdSore]()
            numDifferentSores = 0
            numdifferentLocations = 0
            
            UserDefaults.standard.set(numSores, forKey: "numSores")
            UserDefaults.standard.set(coldSoreObjects, forKey: "coldSoreObjects")
            UserDefaults.standard.set(numDifferentSores, forKey: "numUniqueSores")
            UserDefaults.standard.set(numdifferentLocations, forKey: "numUniqueLocations")
           
          
            print("Reset : There is currently: \(numSores) sores in the system")
            print("Reset : There is currently: \(numDifferentSores) unique sores in the system")
            
            
            
            viewRouter.currentPage = .home
            
        }
        
    }
    func factoryReset(){
        
        withAnimation{
            //Check if the values have been entered on this
            //Uncomment this
            
            indexOfMostRecentSore = 0
            numSores = 0
            coldSoreObjects = [ColdSore]()
            numDifferentSores = 0
            numdifferentLocations = 0
            
            UserDefaults.resetDefaults()
            
            
            
            viewRouter.currentPage = .onboarding
            
        }
        
    }
    
    
}

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}



