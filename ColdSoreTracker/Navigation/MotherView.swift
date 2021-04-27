import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    
    var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ZStack(){
              
                switch viewRouter.currentPage {
                case .launch:
                    Launch_Screen()
                case .onboarding:
                    ProfileSetup()
                case .home:
                    HomePage().transition(.opacity)
                        
                case .calendar:
                    CalendarView().transition(.opacity).frame(width: width, height: height, alignment: .center)//.equatable()
                  
                case .add:
                    AddMenu().transition(.opacity)
                case .settings:
                    Settings().transition(.opacity)
                case .changeName:
                    ChangeName().transition(.opacity)
                case .aboutUs:
                    AboutUs().transition(.opacity)
                case .privacypolicy:
                    PrivacyPolicy().transition(.opacity)
                case .change:
                    EditSore().transition(.opacity)
                }
    
                if (viewRouter.currentPage != .launch && viewRouter.currentPage != .settings && viewRouter.currentPage != .changeName && viewRouter.currentPage != .aboutUs && viewRouter.currentPage != .privacypolicy && viewRouter.currentPage != .change && viewRouter.currentPage != .add){
                    MenuBar()
                }
                
            
            }
  
        }
        
    }
    

}



struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
