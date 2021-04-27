//
//  ColdsoreCell.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 25/4/21.
//

import SwiftUI/*

struct ColdsoreCell: View {
    @EnvironmentObject var viewRouter: ViewRouter
    let coldsore: ColdSore
    let color: Color
    
    var body: some View {
        
        HStack {
            tagView
            Spacer()

            
        }.frame(height: 40)
        .padding(.vertical, 10).contextMenu {
            Button {
                print("Edit ColdSore Selected")
                editPushed()
            } label: {
                Label("Edit Cold Sore", systemImage: "pencil.circle")
            }

            Button {
                delete()
                print("Delete Cold Sore Selected")
            } label: {
                Label("Delete Cold Sore", systemImage: "trash.circle")
            }
        }
        

        
    }
    
    func delete() {
        
      
            coldSoreObjects.removeAll(where: {
                                        $0.id == coldsore.id})
                
            
            if let encoded = try? JSONEncoder().encode(coldSoreObjects) {
                UserDefaults.standard.set(encoded, forKey: "coldSoreObjects")
            }
            numSores -= 1
            

            
            UserDefaults.standard.set(numSores, forKey: "numSores")
            getNumUniques()
            
        }
       
    
    func getNumUniques(){
        
        let mappedItems = coldSoreObjects.map { ($0.reason, 1) }
        let _counts = Dictionary(mappedItems, uniquingKeysWith: +)
        var index = 0
        
        
        for reason in reasons {
            if _counts[reason] != nil {

                index+=1
                    
            } else {
               
            }
        }

        numDifferentSores = index;
       
        UserDefaults.standard.set(numDifferentSores, forKey: "numUniqueSores")
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




struct ColdsoreCell2_Previews: PreviewProvider {
    static var previews: some View {
        ColdsoreCell(coldsore: ColdSore(date: Date(), reason: reasons[4]), color:  Color.blue)
    }
}
*/
