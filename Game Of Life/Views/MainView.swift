import SwiftUI

struct MainView : View {
    @State var colonyData = [Colony("New Colony")]
    @State var currentID = 0
    @State var newName = ""

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ColonyList(colonyData: self.$colonyData, currentID: self.$currentID)
                ColonyView(colony: self.$colonyData[self.currentID], gridLength: geometry.size.height*0.75)
            }
        }
    }
}

