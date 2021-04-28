//
//  MenuBar.swift
//  ColdSoreTracker
//
//  Created by Jason Tubman on 5/4/21.
//

import SwiftUI
var paddingAmountForMenuBar = 50

struct MenuBar: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        GeometryReader { geometry in
                 let width = geometry.size.width
                 let height = geometry.size.height
                 Menubar(viewRouter: _viewRouter, width: width, height: height)
         }
    }
}

struct Menubar: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    let width, height: CGFloat
 
        
    var body: some View {
        
        if UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            
        
        
        //START OF MENU BAR --------------------------
            HStack(){
        
            TabBarIcon(viewRouter: viewRouter, assignedPage: .home, width: width/3.9, height: width/12, systemIconName: "house", tabName: "Home")
        
            ZStack {
                Circle().foregroundColor(.white)
                .frame(width: width/7, height: width/8)
           
                Image(systemName: "plus.circle.fill")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                .frame(width: width/7-6 , height: width/7-6)
                .foregroundColor(Color(hue: 0.482, saturation: 1.0, brightness: 1.0)).onTapGesture {
                    withAnimation {
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHeavy.impactOccurred()
                    viewRouter.currentPage = .add
                        
                    }
                    }
                
         }
        
            TabBarIcon(viewRouter: viewRouter, assignedPage: .calendar, width: width/3.9, height: width/12, systemIconName: "calendar", tabName: "Calendar")
        
            
            }.padding(.vertical, 8.0).background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.9607843137254902, green: 0.9490196078431372, blue: 0.9607843137254902)/*@END_MENU_TOKEN@*/).clipShape(Capsule()).shadow(radius: 10, x:0, y:5).position(x: width/2, y: height - width/8-CGFloat(paddingAmountForMenuBar))
            
            
        //END OF MENU BAR ------------------------------
        
        
        
    }
    
    }
    
}

struct TabBarIcon: View {
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
   
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
               
        }.onTapGesture {
            
            withAnimation{
                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                if (assignedPage == .home){
                    paddingAmountForMenuBar = 50
                } else {
                    paddingAmountForMenuBar = 0
                }
           viewRouter.currentPage = assignedPage
            }
        }.foregroundColor(viewRouter.currentPage != assignedPage ? .gray : .black)
       
       
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar().environmentObject(ViewRouter())
    }
}
