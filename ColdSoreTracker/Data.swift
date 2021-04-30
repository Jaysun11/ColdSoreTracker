//
//  Data.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 5/4/21.
//
import SwiftUI

struct ChartData {
    var id = UUID()
    var name : String
    var color : Color
    var percent : CGFloat
    var value : CGFloat
    
}

var soreEditing: ColdSore = ColdSore(date: Date(), reason: "Mock")

let tabs = [Tab(title:"Welcome To \nCold Sore Tracker", text: "A unique application designed to help you keep track of and avoid cold sores"), Tab(title:"Lets get to know eachother", text: ""), Tab(title : "", text: ""), Tab(title: "", text: ""), Tab(title: "", text: "")]

let reasons = ["Unknown", "Stress", "Impact", "Dry lips (sun/wind/cold)", "Weakened Immune System", "Hormonal Changes", "Other"]

var numDifferentSores : Int = 0

let chartColours = [Color(#colorLiteral(red: 0, green: 1, blue: 0.7477977872, alpha: 1)), Color(#colorLiteral(red: 0.2258948684, green: 0.9796926379, blue: 0.931016624, alpha: 1)), Color(#colorLiteral(red: 0.6634224653, green: 0.5043916702, blue: 0.9632897973, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.1826782823, blue: 0.6522123814, alpha: 1)), Color(#colorLiteral(red: 0.3366200328, green: 0.9985910058, blue: 0.4205998778, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7735200524, blue: 0.1396178603, alpha: 1)), Color(#colorLiteral(red: 0.3146988451, green: 0.6040021777, blue: 0.9974860549, alpha: 1)), Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))]

var numSores: Int = 0

var indexOfMostRecentSore = 0;

var coldSoreObjects = [ColdSore]()

struct ColdSore : Codable, Identifiable{
    var id = UUID()
    
    var date: Date
    var reason: String
    
    var colorindex = Int.random(in: 0..<10)
    
    func getDate() -> Date{
        return date
    }
    func getReason() -> String{
        return reason
    }
    
    func getDaysAgo() -> Int{

        
        let diff = Calendar.current.dateComponents([.day], from: date, to: Date())
        let numberOfDays = diff.day!
        
        return numberOfDays
    }
    
    func toString() -> String{
        return "\(date) | \(reason)"
    }
}

struct Tab{
    let title: String
    let text: String
}
