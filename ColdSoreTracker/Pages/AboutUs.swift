//
//  AboutUs.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 22/4/21.
//

import SwiftUI

struct Developer: View {
    var body: some View {
    Text("Developer").font(.title2).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 1.0)
    Text("Jason Tubman").font(.headline).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 1.0)
    }
}

struct Credits: View {
    var body: some View {
        Text("Credits").font(.title2).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 10.0)
        Text("Thank you to the creators of the\nfollowing libraries:").font(.headline).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 1.0)
        Text("ElegantCalendar").font(.subheadline).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 5.0)
        Text("ElegantPages").font(.subheadline).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, -4.0)
    }
    
}

struct ContactUs: View {
    var body: some View {
        Text("Contact Us").font(.title2).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 10.0)
        Text("If you have any questions or feedback, \nYou can contact us: ").font(.headline).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 1.0)
        
        Text("By email: coldsoretracker@gmail.com").font(.subheadline).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading, 40.0).padding(/*@START_MENU_TOKEN@*/.top, 1.0/*@END_MENU_TOKEN@*/)
        
    }
}
struct Header: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack{
            Image(systemName: "chevron.left").resizable()
                .aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center).position(x:25, y:30).foregroundColor(.gray).opacity(0.7).onTapGesture(perform: {
                    withAnimation{
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHeavy.impactOccurred()
                        viewRouter.currentPage = .settings
                        
                    }
                })
            
            Image("Logo").resizable()
                .aspectRatio(contentMode: .fit).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            
        }.frame(height: 60)
        
        
        Text("About Us").font(.largeTitle/*@END_MENU_TOKEN@*/).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding([.top, .leading]).padding(/*@START_MENU_TOKEN@*/.vertical)
        
    }
}

struct Privacy: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        Text("Privacy Policy").font(.title2).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 10.0)
        ZStack{
            
            
        HStack(alignment: .center){
        Text("Click Here to view our privacy policy ").font(.headline).foregroundColor(Color.gray).bold().multilineTextAlignment(.leading).padding(.leading).padding(.top, 10.0)
            Image(systemName: "chevron.right").foregroundColor(.gray).padding(.top, 10.0)
            
        }.onTapGesture(perform: {
            withAnimation{
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                viewRouter.currentPage = .privacypolicy
                
            }
        })
            
        }
        
    }
}

struct AboutUs: View {

    var body: some View {
        GeometryReader { geometry in
            
            ScrollView{
            
            VStack(alignment: .leading){
                Header()
                
                Developer()
                Credits()
                ContactUs()
                Privacy()
                
                
            }
            }
        
            
            
        }
        
    }
    
    }
    


struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
