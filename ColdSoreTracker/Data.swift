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


let tabs = [Tab(title:"Welcome To \nCold Sore Tracker", text: "A unique application designed to help you keep track of and avoid cold sores"), Tab(title:"Lets get to know eachother", text: ""), Tab(title : "", text: ""), Tab(title: "", text: ""), Tab(title:"", text:"")]

let reasons = ["Unknown", "Stress", "Impact", "Dry lips (sun/wind/cold)", "Weakened Immune System", "Hormonal Changes"]

var numDifferentSores : Int = 0

let chartColours = [Color(#colorLiteral(red: 0, green: 1, blue: 0.9278313518, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.4650866389, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.1826782823, blue: 0.6522123814, alpha: 1)), Color(#colorLiteral(red: 0.3366200328, green: 0.9985910058, blue: 0.4205998778, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7735200524, blue: 0.1396178603, alpha: 1)), Color(#colorLiteral(red: 0.6610245109, green: 0.4582415819, blue: 1, alpha: 1))]

var numSores: Int = 0

var indexOfMostRecentSore = 0;

var coldSoreObjects = [ColdSore]()

struct ColdSore : Codable{
    var date: Date
    var reason: String
    
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
