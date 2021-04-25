//
//  ColdsoreCell.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 25/4/21.
//

import SwiftUI

struct ColdsoreCell: View {
    @EnvironmentObject var viewRouter: ViewRouter
    let coldsore: ColdSore
    let color: Color
    
    var body: some View {
        
        HStack {
            tagView
            Spacer()
            
        }.frame(height: 40)
        .padding(.vertical, 10).onTapGesture(perform: {
            editPushed()
        })
       
        
    }
    
    func editPushed(){
        viewRouter.currentPage = .change
        soreEditing = coldsore
        
    }
    
}

private extension ColdsoreCell {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var tagView: some View {
        HStack{
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 5, height: 40, alignment: .leading).foregroundColor(color)
            VStack(alignment: .leading){
                Text("Reason: \(coldsore.reason)")
                    .padding(.horizontal)
                Text((dateFormatter.string(from: coldsore.getDate())))
                    .font(.system(size: 16))
                    .lineLimit(1).padding(.horizontal)
            }
        }
    }
    
    

}




struct ColdsoreCell_Previews: PreviewProvider {
    static var previews: some View {
        ColdsoreCell(coldsore: ColdSore(date: Date(), reason: reasons[4]), color:  Color.blue)
    }
}
