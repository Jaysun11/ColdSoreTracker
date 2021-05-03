//
//  AverageHealingTime.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 1/5/21.
//

import SwiftUI

struct AverageHealingTime: View {

    @State var labels = [String]()
    @State var data = [Double]()

    
    
    init(){
        populateChartData()
    }
   
    var body: some View {
        
    
        VStack(alignment: .leading){
            Text("Average Healing Time").font(.title).fontWeight(.semibold).foregroundColor(.black).opacity(0.6).multilineTextAlignment(.leading).padding(.top, 10.0)
            if(averageduration == 0 || averageduration.isNaN){//Change this to 0 after testing done
                Text("Add a duration to either a new / one of your existing cold sores to track average healing times.").font(.headline).foregroundColor(.black).opacity(0.6).padding(.top)
                Text("Simply navigate to the calendar, long press a cold sore, select edit, and add a duration, easy!").font(.callout).foregroundColor(.black).opacity(0.6).padding(.top)
                HStack(alignment: .center){
                    Text("Look for the calendar logo\non the menu below" ).foregroundColor(.black).opacity(0.6)
                    Spacer()
                    Image(systemName: "calendar").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25).foregroundColor(.black).opacity(0.6)
                    Spacer()
                }.padding(.top)
            } else {
                ZStack{
                //Show average data here
                BarGraph(data: $data, labels: $labels, accentColor: Color.blue, axisColor: Color.green, showGrid: false, gridColor: Color.black, spacing: 5.0)
                    Text("Duration (days)").font(.caption).rotationEffect(.degrees(-90)).position(x: 8, y: CGFloat(55 + 12*numDifferentSores))
                    
                }.onAppear(perform: {
                    print(averageduration)
                })
                
                Text("The average time for your cold sores to heal is: \(String(format: "%.2f", averageduration)) days.").foregroundColor(.black).opacity(0.6).padding(.top)
                
                Text("This data is calculated using the sore durations provided in the calendar view, to upate this data edit your cold sores to accurately represent their healing times.").font(.caption2).foregroundColor(.black).opacity(0.6).padding(.top)
                
            }
                
            
            Spacer()
            
          
        }.frame(width:280, height: height-60).onAppear(perform: {
            populateChartData()
        })
    }
    
    func populateChartData(){
        //let mappedItems = coldSoreObjects.map { ($0.reason, 1) }
        let mappedItems = coldSoreObjects.map { ($0.reason, $0.duration) }
        let _counts = Dictionary(mappedItems, uniquingKeysWith: { ($0 ?? 0) + ($1 ?? 0) })
      
        labels.removeAll()
        data.removeAll()
        for reason in reasons {
            if let occurences = _counts[reason] {
                labels.append(reason)
                data.append(Double(occurences ?? 0))
            }
        }


    }
}

struct AverageHealingTime_Previews: PreviewProvider {
    static var previews: some View {
        AverageHealingTime()
    }
}
