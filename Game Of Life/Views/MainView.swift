import SwiftUI

struct MainView : View {
    @State var colonyData = [
        Colony("C1", 60,
            [Coordinate(5,5),
            Coordinate(5,6),
            Coordinate(5,7),
            Coordinate(6,6)
        ]),
        Colony("C2", 60,
            [Coordinate(15,15),
            Coordinate(15,16),
            Coordinate(15,17),
            Coordinate(16,16)
        ]),
        Colony("C3", 60,
            [Coordinate(25,25),
            Coordinate(25,26),
            Coordinate(25,27),
            Coordinate(26,26)
        ]),
        Colony("C4", 60,
            [Coordinate(35,35),
            Coordinate(35,36),
            Coordinate(35,37),
            Coordinate(36,36)
        ]),
        Colony("C5", 60,
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
            HStack {
                ColonyList(colonyData: self.$colonyData, currentID: self.$currentID)
                    .frame(width: geometry.size.width / 4, height: geometry.size.height)
                Spacer()
                ColonyView(colony: self.$colonyData[self.currentID])
                    .offset(x: -185, y: 0)
                .frame(width: 500, height: 500)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if !self.colonyData[self.currentID].isCellAlive(self.convertToCoordinates(Double(value.location.y), Double(value.location.x))) {
                                self.colonyData[self.currentID].setCellAlive(self.convertToCoordinates(Double(value.location.y), Double(value.location.x)))
                            }
                        }
                )
            }
        }
    }
    
    func convertToCoordinates(_ x: Double, _ y: Double)-> Coordinate {
        return Coordinate(Int(x/8.3333333), Int(y/8.3333333))
    }
}
