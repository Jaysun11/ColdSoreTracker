//
//  ChangeName.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 22/4/21.
//

import SwiftUI

struct NameHeader: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack{
            Image(systemName: "chevron.left").resizable()
                .aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center).position(x:25, y:30).foregroundColor(.black).opacity(0.6).onTapGesture(perform: {
                    withAnimation{
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHeavy.impactOccurred()
                        viewRouter.currentPage = .settings
                        
                    }
                })
            
            Image("Logo").resizable()
                .aspectRatio(contentMode: .fit).frame(width: 60, height: 60, alignment: .center).clipShape(Circle())
            
            
        }.frame(height: 60)
        
        
        Text("Update Name").font(.largeTitle/*@END_MENU_TOKEN@*/).fontWeight(.bold).foregroundColor(.black).opacity(0.6).multilineTextAlignment(.leading).padding([.top, .leading]).padding(/*@START_MENU_TOKEN@*/.top)
    }
}


struct ChangeName: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var showingAlert = false
    @State private var name : String = ""
    var body: some View {
        GeometryReader { geometry in
            
            
            let width = geometry.size.width
           
           
            
            VStack(alignment: .leading){
                
                
                NameHeader()
                
                Text("What would you like us to call you?").font(.title3).foregroundColor(.black).opacity(0.6).multilineTextAlignment(.leading).padding(.leading).padding(.top, 1.0)
                
                HStack{
                    
                    TextField(UserDefaults.standard.string(forKey: "name") ?? "Update Name", text: $name)
                        .padding(.all)
                        .multilineTextAlignment(.center).background(Color.black.opacity(0.05)).cornerRadius(2)
                        .onChange(of: name) { newValue in
                            print("updated name to \(name)")
                            //
                        }.padding(.leading, 16.0).frame(width: width/1.5, height: 50)
                    
                    Button(action: {showAlert()}, label: {
                        Text("Update").fontWeight(.heavy).frame(width: width/3.7, height: 53).background(Color.black.opacity(0.05)).cornerRadius(2).foregroundColor(Color.black.opacity(0.4))
                    }).alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("Are You Sure?"),
                            message: Text("\nUpdate name to \(name)"),
                            primaryButton: .destructive(Text("Confirm")) {
                                
                               
                                print("Name Updated to ... \(name)")
                               
                                saveName()
                                
                                
                                
                            },
                            secondaryButton: .cancel(){
                           
                            }
                            
                        )
                    }
                    
                }
                .padding(.top, 5.0)
                
                
                
                
                
                
                
            }
            
            
        }
    }
    func showAlert(){
        if (name == ""){
            
        } else {
        showingAlert = true;
        }
    }
    
    func saveName(){
        UserDefaults.standard.set(name, forKey: "name")
        viewRouter.currentPage = .settings
    }
}

struct ChangeName_Previews: PreviewProvider {
    static var previews: some View {
        ChangeName()
    }
}
