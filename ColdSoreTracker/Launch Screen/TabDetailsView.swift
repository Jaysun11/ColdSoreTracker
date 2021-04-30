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
                VStack{
                    VStack{
                        Image("LogoTrans").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.bottom, -25.0).offset(x: 0, y: -30)
                        Text("Cold Sore Tracker").font(.headline).bold().multilineTextAlignment(.center).offset(y:-65)
                    }.frame(width:350, height: 250, alignment: .center).padding(.bottom, -25)
                    
                    
                VStack{
                    
                    Text("Lets talk cold sores").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().multilineTextAlignment(.center).padding(.bottom, 5).frame(width: 300)
                    
                    
                    Text("When was your last cold sore?").foregroundColor(Color.black.opacity(0.27)).multilineTextAlignment(.center).frame(width: 300)
                    
                    
                    DatePicker("", selection: $lastSore, in: ...Date(), displayedComponents: .date).frame(width: 330).onChange(of: lastSore) { newValue in
                        UserDefaults.standard.set(lastSore, forKey: "firstSoreDate")
                        print("Changed date of first sore to \(lastSore)")
                        }.accentColor(Color.black.opacity(0.6)).frame(width: 120, height: screen.size.width*0.12, alignment: .center).labelsHidden()
                    
                }.padding(.bottom, 25)
                    
                
                }
            case 3:
                VStack{
                    
                    VStack{
                        Image("LogoTrans").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.bottom, -25.0).offset(x: 0, y: -30)
                        Text("Cold Sore Tracker").font(.headline).bold().multilineTextAlignment(.center).offset(y:-65)
                    }.frame(width:350, height: 250, alignment: .center).padding(.bottom, -25)
                    
            
            Text("The smaller details").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().multilineTextAlignment(.center).padding(.bottom, 5).padding(.top, 10)
            
            
            Text("How was it triggered?").foregroundColor(Color.black.opacity(0.27)).multilineTextAlignment(.center)
                    ZStack{
                        Rectangle().fill(Color.black.opacity(0.07)).cornerRadius(7).frame(width: 220, height: 35)
                        Picker(selectedReason, selection: $selectedReason, content: {
                            ForEach(reasons, id: \.self, content: { reason in
                                Text(reason)
                            })
                        }).padding(.vertical, 20).foregroundColor(Color.black.opacity(0.6)).onChange(of: selectedReason, perform: { value in
                            UserDefaults.standard.set(selectedReason, forKey: "firstSoreReason")
                            
                        }).pickerStyle(MenuPickerStyle()).accentColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/).frame(width: 220, height: 40)
                    }
            }.padding(.bottom, 25)
                
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

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct TabDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(){
            GradientView()
            TabDetailsView(index: 3)
        }
        
    }
}
