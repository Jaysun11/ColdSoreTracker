//
//  TypesOfSoresChart.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 22/4/21.
//

import SwiftUI

struct TypesOfSoresChart: View {
    var body: some View {
        DonutChart()
    }
}

struct TypesOfSoresChart_Previews: PreviewProvider {
    static var previews: some View {
        TypesOfSoresChart()
    }
}

class ChartDataContainer : ObservableObject {
    @Published var chartData = [ChartData]()
    var largestpercentIndex = 0

    
    init() {
        populateChartData()
        calc()
    }
    func populateChartData(){
        
        let mappedItems = coldSoreObjects.map { ($0.reason, 1) }
        let _counts = Dictionary(mappedItems, uniquingKeysWith: +)
        var index = 0
        
        var checkLargest = 0
        
        for reason in reasons {
            if let occurences = _counts[reason] {
                chartData.append(ChartData(name: reason, color: chartColours[index], percent: CGFloat(Double(occurences)/Double(coldSoreObjects.count)*100), value: 0))
                
                if (occurences >= checkLargest){
                    checkLargest = occurences
                    largestpercentIndex = index
                }
                index+=1
                    
            } else {
               
            }
        }

        numDifferentSores = index;
       
        UserDefaults.standard.set(numDifferentSores, forKey: "numUniqueSores")
    }
    
    func calc(){
        var value : CGFloat = 0
        
        for i in 0..<chartData.count {
            value += chartData[i].percent
            chartData[i].value = value
        }
    }
}



struct DonutChart : View {
    @ObservedObject var charDataObj = ChartDataContainer()
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
                        .font(.title)
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
                                    .font(indexOfTappedSlice == index ? .headline : .subheadline)
                            }
                            
                        }
                        .padding(8)
                        .frame(width: 300, alignment: .leading)
            
            
            
        }.onAppear(){
            indexOfTappedSlice = charDataObj.largestpercentIndex
        }
    }
}
