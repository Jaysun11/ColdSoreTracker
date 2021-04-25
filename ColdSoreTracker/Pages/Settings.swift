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
                .frame(width: 40, height: 40).foregroundColor(.gray).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            
            ZStack{
            Rectangle().opacity(0).frame(width: width/1.4, height: 50, alignment: .leading).contentShape(Rectangle())
            Text(tabName)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
                .padding(.leading, 5.0)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/).frame(width: width/1.4, height: 50, alignment: .leading)
            }
            
            
            Image(systemName: "chevron.right")
                .padding(.trailing, 10.0).foregroundColor(.gray).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
               
        }
        .padding(.leading, 10.0)
        
       
    }
    
}

struct Settings: View {
    
    @State private var showingAlert = false
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        
        GeometryReader { geometry in
                
            let width = geometry.size.width
            
            
        ZStack{
                Image(systemName: "chevron.left").resizable()
                    .aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center).position(x:25, y:30).foregroundColor(.gray).opacity(0.7).onTapGesture(perform: {
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
            
            Text("Settings").font(.largeTitle).foregroundColor(.gray).padding(.top, 60.0).padding(/*@START_MENU_TOKEN@*/.leading, 10.0/*@END_MENU_TOKEN@*/)
            
            buttonView(systemIconName: "person.circle", tabName: "Update Name", width: width).padding(.top, 10.0).onTapGesture(perform: {
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
            
    
            
            buttonView(systemIconName: "trash.circle", tabName: "Reset Data", width: width).onTapGesture(perform: {
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                showingAlert = true
            }).alert(isPresented:$showingAlert) {
                Alert(
                    title: Text("Reset All App Data?"),
                    message: Text("\nThere is no way to undo this action"),
                    primaryButton: .destructive(Text("Reset")) {
                        print("Resetting...")
                        
                        reset()
                    },
                    secondaryButton: .cancel(){}
           
                )
            }
            
            
            
        }.padding(.all).lineSpacing(15)
            
            
            
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
            
            UserDefaults.standard.set(numSores, forKey: "numSores")
            UserDefaults.standard.set(coldSoreObjects, forKey: "coldSoreObjects")
            UserDefaults.standard.set(numDifferentSores, forKey: "numUniqueSores")
           
          
            print("Reset : There is currently: \(numSores) sores in the system")
            print("Reset : There is currently: \(numDifferentSores) unique sores in the system")
            
            
            
            viewRouter.currentPage = .home
            
        }
        
    }
    
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}


