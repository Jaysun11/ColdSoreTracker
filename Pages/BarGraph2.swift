//
//  BarGraph.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 1/5/21.
//

import SwiftUI

struct BarGraph2: View {
    @Binding var data: [Double]
    @Binding var labels: [String]
    let accentColor: Color
    let axisColor: Color
    let showGrid: Bool
    let gridColor: Color
    let spacing: CGFloat
    @State private var opacity: Double = 0

    
    private var minimum: Double { (data.min() ?? 0) * 0.95 }
    private var maximum: Double { (data.max() ?? 1) * 1.05 }
    
    var body: some View {
        VStack {
            ZStack {
                
                if showGrid {
                    BarChartGrid(divisions: 10)
                        .stroke(gridColor.opacity(0.2), lineWidth: 0.5)
                }
                
                
                BarStack2(data: $data,
                         labels: $labels,
                         accentColor: accentColor,
                         gridColor: gridColor,
                         showGrid: showGrid,
                         min: minimum,
                         max: maximum,
                         spacing: spacing).onAppear(perform: {
                            withAnimation(.linear(duration: 1)) {
                                opacity = 1
                            }
                         }).opacity(opacity)
                
                BarChartAxes()
                    .stroke(Color.black, lineWidth: 2)
                
                
                
                
            }
            
            LabelStack(labels: $labels, spacing: spacing)
            
        }
        .padding([.horizontal, .top], 20)
    }
}





struct BarStack2: View {
    @Binding var data: [Double]
    @Binding var labels: [String]
    let accentColor: Color
    let gridColor: Color
    let showGrid: Bool
    let min: Double
    let max: Double
    let spacing: CGFloat
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: spacing) {
            
            ForEach(0 ..< data.count, id: \.self) { index in
                LinearGradient(
                    gradient: .init(
                        stops: [
                            //.init(color: Color.white.opacity(0.6), location: 0),
                            //.init(color: chartColours[index].opacity(0.7), location: 0.2),
                            .init(color: chartColours2[index], location: 1)
                        ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .clipShape(BarPath(data: data[index], max: max, min: 0))
            }
            
        }
        //.shadow(color: .black, radius: 5, x: 1, y: 1)
        .padding(.horizontal, spacing)
    }
    
}

struct BarGraph2_Previews: PreviewProvider {
    @State static var labels = ["1", "2"]
    @State static var data = [10.0, 5.1]
    static var previews: some View {
        BarGraph(data: $data, labels: $labels, accentColor: Color.blue, axisColor: Color.green, showGrid: true, gridColor: Color.black.opacity(1), spacing: 5)
    }
}
