//
//  LocationView.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 5/5/21.
//

import SwiftUI

struct LocationView: View {
    var body: some View {
        ZStack{
            if (numdifferentLocations == 0){
                Text("Track your first sore location to display insights here").foregroundColor(.black).opacity(0.6).frame(width: screen.size.width-30)
            } else {
                VStack{
                    Text("Your Cold Sore Locations").font(.title).foregroundColor(.black).opacity(0.6).padding(.bottom, 10)
                    PieChart()
                }
            }
        }
        
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}

class ChartDataContainer2 : ObservableObject {
    @Published var chartData = [ChartData]()
    var largestpercentIndex = 0

    
    init() {
        populateChartData()
        calc()
    }
    func populateChartData(){
        
        let mappedItems = coldSoreObjects.map { ($0.location, 1) }
        let _counts = Dictionary(mappedItems, uniquingKeysWith: +)
        var index = 0
        
        var checkLargest = 0
        
        for location in locations {
            if let occurences = _counts[location] {
                chartData.append(ChartData(name: location, color: chartColours2[index], percent: CGFloat(Double(occurences)/Double(coldSoreObjects.count)*100), value: 0))
                
                if (occurences >= checkLargest){
                    checkLargest = occurences
                    largestpercentIndex = index
                }
                index+=1
                    
            } else {
               
            }
        }

    }
    
    func calc(){
        var value : CGFloat = 0
        
        for i in 0..<chartData.count {
            value += chartData[i].percent
            chartData[i].value = value
        }
    }
}




struct PieChart : View {
    @ObservedObject var charDataObj = ChartDataContainer2()
    @State var indexOfTappedSlice = -1
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<charDataObj.chartData.count) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                              to: charDataObj.chartData[index].value/100)
                        .stroke(charDataObj.chartData[index].color,lineWidth: 50)
                      
                        
                        .onTapGesture {
                            indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                        }
                        .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                        .animation(.spring())
                }
                if indexOfTappedSlice != -1 {
                    Text(String(format: "%.2f", Double(charDataObj.chartData[indexOfTappedSlice].percent))+"%")
                        .font(.title).foregroundColor(.black).opacity(0.6)
                }
            }
            .frame(width: 200, height: 250)
            .padding()
            .onAppear() {
                self.charDataObj.calc()
            }
            
            
            ForEach(0..<charDataObj.chartData.count) { index in
                            HStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(charDataObj.chartData[index].color)
                                    .frame(width: 15, height: 15)
                                
                                Text("\(charDataObj.chartData[index].name)  " /*+ String(format: "%.2f", Double(charDataObj.chartData[index].percent))+"%"*/)
                                    .onTapGesture {
                                        indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                                    }
                                    .font(indexOfTappedSlice == index ? .headline : .subheadline).foregroundColor(.black).opacity(0.6)
                            }
                            
                        }
                        .padding(8)
                        .frame(width: 280, alignment: .leading)
            
            
            
        }.onAppear(){
            indexOfTappedSlice = charDataObj.largestpercentIndex
        }
    }
}




