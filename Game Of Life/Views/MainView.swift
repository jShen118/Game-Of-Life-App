import SwiftUI

struct MainView : View {
    @State var colonyData = [
        Colony("Colony 1", 60,
            [Coordinate(5,5),
            Coordinate(5,6),
            Coordinate(5,7),
            Coordinate(6,6)
        ]),
        Colony("Colony 2", 60,
            [Coordinate(15,15),
            Coordinate(15,16),
            Coordinate(15,17),
            Coordinate(16,16)
        ]),
        Colony("Colony 3", 60,
            [Coordinate(25,25),
            Coordinate(25,26),
            Coordinate(25,27),
            Coordinate(26,26)
        ]),
        Colony("Colony 4", 60,
            [Coordinate(35,35),
            Coordinate(35,36),
            Coordinate(35,37),
            Coordinate(36,36)
        ]),
        Colony("Colony 5", 60,
            [Coordinate(45,45),
            Coordinate(45,46),
            Coordinate(45,47),
            Coordinate(46,46)
        ]),
    ]
    @State var currentID = 0
    @State var newName = ""

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ColonyList(colonyData: self.$colonyData, currentID: self.$currentID)
                if self.colonyData.count > 0 {
                    ColonyView(colony: self.$colonyData[self.currentID], gridLength: geometry.size.height*0.8)
                    //.frame(width: geometry.size.height*0.9)
                } else {Text("No Colonies")}
            }
        }
    }
}

