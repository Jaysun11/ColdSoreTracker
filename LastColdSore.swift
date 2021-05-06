//
//  LastColdSore.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 6/4/21.
//

import SwiftUI

struct LastColdSore: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            
            if (numSores == 0){
                //Theres no Sores
                ZStack{
                    Rectangle().frame(height:180).cornerRadius(15).padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    
                    VStack(alignment: .leading){
                        Text("No Cold Sores To Display")
                            .font(.title).fontWeight(.bold).foregroundColor(.black).opacity(0.6)
                            .multilineTextAlignment(.leading).padding(.bottom, 6)
                        HStack(){
                            Text("Click the add button below")
                                .font(.title2).foregroundColor(.black).opacity(0.6)
                                .multilineTextAlignment(.leading)
                            
                            
                        }
                        
                    }.frame(width: screen.size.width-20)
                }
                
            } else {
                
                let mostRecentSore = coldSoreObjects[indexOfMostRecentSore]//Get most recent sore
                let daysago = mostRecentSore.getDaysAgo()
                let date = (dateFormatter.string(from: mostRecentSore.getDate()))
                let reason = mostRecentSore.getReason()
                let location = mostRecentSore.location
                ZStack{
                    Rectangle().frame(height: 180).cornerRadius(15).padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    VStack(alignment: .leading){
                        Text("Your Last Cold Sore")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black).opacity(0.6)
                            .multilineTextAlignment(.leading).padding(.bottom, -1.5)
                        HStack(){
                            Text("Was")
                                .font(.title2)
                                .multilineTextAlignment(.leading).foregroundColor(.black).opacity(0.6)
                            Text("\(daysago)")
                                .font(.title).bold().foregroundColor(Color(#colorLiteral(red: 0, green: 1, blue: 0.8056185842, alpha: 1)))
                                .multilineTextAlignment(.leading)
                            Text("days ago")
                                .font(.title2)
                                .multilineTextAlignment(.leading).foregroundColor(.black).opacity(0.6)
                            
                        }.padding(.bottom, -1)
                        VStack(alignment: .leading){
                            
                            Text("Date: \(date) ")
                                .font(.body)
                                .multilineTextAlignment(.leading).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.4))
                            
                            
                            Text("Location: \(location ?? "Unknown")").padding(.top, -2)
                                .font(.body)
                                .multilineTextAlignment(.leading).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.4))
                            
                            
                            Text("Cause: \(reason) ").padding(.top, -2)
                                .font(.body)
                                .multilineTextAlignment(.leading).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.4))
                            
                        }
                        
                        
                        
                    }.padding(.top, 0).offset(x: 0).frame(width: geometry.size.width-70, alignment: .leading)
                }
            }
            
            
        }
        
        
    }
}




struct LastColdSore_Previews: PreviewProvider {
    static var previews: some View {
        LastColdSore()
    }
}
