import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    
    var body: some View {
        ZStack(){
        switch viewRouter.currentPage {
        case .launch:

            Launch_Screen()
        case .onboarding:
                ProfileSetup()
        case .home:
 
            HomePage().transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                

        case .calendar:
            
                CalendarView().transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            
        case .add:

                AddMenu().transition(.opacity)
                
        }
        
            if (viewRouter.currentPage != .launch){
                MenuBar()
            }
        
        }
        
       
        
    }
    
  
}



struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
