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
                    HomePage().transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                case .calendar:
                    CalendarView().transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))).frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)//.equatable()
                  
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
    
                if (viewRouter.currentPage != .launch && viewRouter.currentPage != .settings && viewRouter.currentPage != .changeName && viewRouter.currentPage != .aboutUs && viewRouter.currentPage != .privacypolicy && viewRouter.currentPage != .change){
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
