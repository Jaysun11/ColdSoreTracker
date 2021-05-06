//
//  AverageHealingTimeLocation.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 5/5/21.
//

import SwiftUI

struct AverageHealingTimeLocation: View {
    
    @State var labels = [String]()
    @State var data = [Double]()
    
    
    
    init(){
        populateChartData()
    }
    
    var body: some View {
        
        
        VStack(alignment: .leading){
            Text("Average Healing Time (Location)").font(.headline).fontWeight(.medium).foregroundColor(.black).opacity(0.6).multilineTextAlignment(.leading).padding(.top, 10.0)
            if(averageduration == 0 || averageduration.isNaN || numdifferentLocations == 0){//Change this to 0 after testing done
                Text("Add a duration and location to either a new / one of your existing cold sores to track average healing times per location.").font(.subheadline).foregroundColor(.black).opacity(0.6).padding(.top)
                Text("Navigate to the calendar, long press a cold sore, select edit, and add a duration and location.").font(.footnote).foregroundColor(.black).opacity(0.6).padding(.top)
                HStack(alignment: .center){
                    Text("Look for the calendar logo\non the menu below" ).foregroundColor(.black).opacity(0.6)
                    Spacer()
                    Image(systemName: "calendar").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25).foregroundColor(.black).opacity(0.6)
                    Spacer()
                }.padding(.top)
            } else {
                withAnimation(){
                ZStack{
                    //Show average data here
                   
                        
                        BarGraph2(data: $data, labels: $labels, accentColor: Color.blue, axisColor: Color.green, showGrid: false, gridColor: Color.black, spacing: 5.0)
                        Text("Duration (days)").font(.caption).rotationEffect(.degrees(-90)).position(x: 8, y: CGFloat(85 + 13*numdifferentLocations))
                        
                    }
                }
                
                
                Text("The average time for your cold sores to heal is: \(String(format: "%.2f", averageduration)) days.").foregroundColor(.black).opacity(0.6).padding(.top)
                
                Text("This data is calculated using the sore durations and locations provided in the calendar view, to upate this data edit your cold sores to accurately represent their healing times.").font(.caption2).foregroundColor(.black).opacity(0.6).padding(.top)
                
            }
            
            
            Spacer()
            
            
        }.frame(width:280, height: height-60).onAppear(perform: {
            populateChartData()
        })
    }
    
    func populateChartData(){
        //let mappedItems = coldSoreObjects.map { ($0.reason, 1) }
        let mappedItems = coldSoreObjects.map { ($0.location, $0.duration) }
        let _counts = Dictionary(mappedItems, uniquingKeysWith: { ($0 ?? 0) + ($1 ?? 0) })
        
        labels.removeAll()
        data.removeAll()
        for location in locations {
            if let occurences = _counts[location] {
                labels.append(location)
                data.append(Double(occurences ?? 0))
            }
        }
        
        
    }
}

struct AverageHealingTimeLocation_Previews: PreviewProvider {
    static var previews: some View {
        AverageHealingTimeLocation()
    }
}
