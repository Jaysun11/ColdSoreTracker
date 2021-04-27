//
//  TabDetailsView.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 5/4/21.
//

import SwiftUI


struct TabDetailsView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selectedReason: String = "Unknown"
    @State private var lastSore: Date = Date()
    @State private var name : String = ""
    
 
    
 
    
    let index: Int
    
    var body: some View {
        VStack(){
            
            switch index{
            case 0:
                VStack(){
                Image("LogoTrans").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.bottom, -25.0)
                Text(tabs[index].title).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().multilineTextAlignment(.center)
                Text(tabs[index].text).multilineTextAlignment(.center).padding(.top)
                }

                
                
            case 1:
                VStack(alignment: .center){
                    Text(tabs[1].title).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().multilineTextAlignment(.center)
                    
                    TextField("What should we call you?", text: $name).padding().multilineTextAlignment(.center).background(Color(#colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.5956667945))).cornerRadius(/*@START_MENU_TOKEN@*/12.0/*@END_MENU_TOKEN@*/)
                        .onChange(of: name) { newValue in
                            print("updated name to \(name)")
                            UserDefaults.standard.set(name, forKey: "name")
                        }
                   
                
                }
            case 2:
                VStack(){
                Text("Lets talk cold sores").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().multilineTextAlignment(.center).padding(.bottom, 5)
                
                
                Text("When was your last cold sore?").foregroundColor(Color.black.opacity(0.27)).multilineTextAlignment(.center)
                
                DatePicker("", selection: $lastSore, in: ...Date(), displayedComponents: .date).frame(width: 330) .datePickerStyle(WheelDatePickerStyle()).foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                }.onChange(of: lastSore) { newValue in
                    UserDefaults.standard.set(lastSore, forKey: "firstSoreDate")
                    print("Changed date of first sore to \(lastSore)")
                    
                }
                
                
            case 3:
                VStack(){
                Text("The smaller details").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().multilineTextAlignment(.center).padding(.bottom, 5)
                
                    
                Text("How was it triggered?").foregroundColor(Color.black.opacity(0.27)).multilineTextAlignment(.center)
                
                Picker("Select an option", selection: $selectedReason, content: {
                                ForEach(reasons, id: \.self, content: { reason in
                                    Text(reason)
                                        .foregroundColor(.black)
                                })
                }).padding(.top, -30).frame(width: 330)
                .onChange(of: selectedReason) { newValue in
                    UserDefaults.standard.set((selectedReason), forKey: "firstSoreReason")
                    print("Changed how it was first triggered to \(selectedReason)")
                    
                }
                    
                    
                    
                }
            case 4:
                VStack(){
                Text("Thats all!").font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/).bold().multilineTextAlignment(.center).padding(.bottom, 5)
                
                Text("You've just tracked your very first cold sore").foregroundColor(Color.black.opacity(0.27)).multilineTextAlignment(.center)
               
                Text("Click 'Start Tracking' to continue").foregroundColor(Color.black.opacity(0.27)).multilineTextAlignment(.center).offset(y: 250)
                }
                .onDisappear(){
                    
                
                    //saving coldsore
                    
                    coldSoreObjects.removeAll()
                    
                    if (UserDefaults.standard.value(forKey: "firstSoreDate") == nil){
                        UserDefaults.standard.set(Date(), forKey: "firstSoreDate")
                    }
                    coldSoreObjects.append(ColdSore(date: UserDefaults.standard.value(forKey: "firstSoreDate") as! Date, reason: UserDefaults.standard.string(forKey: "firstSoreReason") ?? "Unknown"))
                
                    
                    
                    //Storing Items
                    if let encoded = try? JSONEncoder().encode(coldSoreObjects) {
                        UserDefaults.standard.set(encoded, forKey: "coldSoreObjects")
                    }
                    
                    numSores = 1
                    
                    UserDefaults.standard.set(1, forKey: "numSores")
                    
                    numDifferentSores = 1;
                    UserDefaults.standard.set(1, forKey: "numDifferentSores")
                   
                    
                }
                
            default:
                Text("")
            }
            
            
        }.padding(.horizontal).foregroundColor(.white)
        
        
        
        
    }


   
    
}


struct TabDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(){
            GradientView()
            TabDetailsView(index: 3)
        }
        
    }
}
