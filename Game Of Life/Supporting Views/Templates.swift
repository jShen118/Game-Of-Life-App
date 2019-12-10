import SwiftUI

struct Templates: View {
    @Binding var colonyData: [Colony]
    @Binding var isAdding: Bool
    @Binding var currentID: Int
    
    func buttonAction(_ t: String) {
        self.isAdding.toggle()
        switch t {
        case "Blank": setBlank()
        case "Basic": setBasic()
        case "Glider": setGlider()
        case "Glider Gun": setGliderGun()
        default: setBlank()
        }
        self.currentID = self.colonyData.count - 1
    }
    
    var body: some View {
        VStack {
            Text("Choose a Template")
            .font(.largeTitle)
            .padding()
            HStack {
                Button(action: {self.buttonAction("Blank")}) {
                    ZStack {
                        self.blankIcon.frame(width: 250, height: 250)
                        Text("Blank").foregroundColor(Color.black).font(.largeTitle).bold()
                    }
                }
               Button(action: {self.buttonAction("Basic")}) {
                   ZStack {
                    self.basicIcon.frame(width: 250, height: 250)
                       Text("Basic").foregroundColor(Color.black).font(.largeTitle).bold()
                   }
               }
            }
            HStack {
                Button(action: {self.buttonAction("Glider")}) {
                    ZStack {
                        self.gliderIcon.frame(width: 250, height: 250)
                        Text("Glider").foregroundColor(Color.black).font(.largeTitle).bold()
                    }
                }
                Button(action: {self.buttonAction("Glider Gun")}) {
                    ZStack {
                        self.gliderGunIcon.frame(width: 250, height: 250)
                        Text("Glider Gun").foregroundColor(Color.black).font(.largeTitle).bold()
                    }
                }
            }
        }
    }
}

extension Templates {
    func setBlank() {
        self.colonyData.append(Colony("New Colony", 60, []))
    }
    func setBasic() {
        self.colonyData.append(Colony("New Colony", 60, [
            Coordinate(20,20), Coordinate(20,21), Coordinate(20,22), Coordinate(21,21)
        ]))
    }
    func setGlider() {
        self.colonyData.append(Colony("New Colony", 60, [
            Coordinate(10,8), Coordinate(10,9), Coordinate(10,10), Coordinate(11,10), Coordinate(12,9)
        ]))
    }
    func setGliderGun() {
        self.colonyData.append(Colony("New Colony", 60, [
            Coordinate(5,1), Coordinate(5,2), Coordinate(6,1), Coordinate(6,2), Coordinate(5,11), Coordinate(6,11), Coordinate(7,11), Coordinate(9,13), Coordinate(9,14), Coordinate(4,12), Coordinate(3,13), Coordinate(3,14), Coordinate(6,15), Coordinate(4,16), Coordinate(8,16), Coordinate(8,12), Coordinate(5,17), Coordinate(6,17), Coordinate(7,17), Coordinate(6,18), Coordinate(5,21), Coordinate(4,21), Coordinate(3,21), Coordinate(5,22), Coordinate(4,22), Coordinate(3,22), Coordinate(2,23), Coordinate(6,23), Coordinate(6,25), Coordinate(7,25), Coordinate(1,25), Coordinate(2,25), Coordinate(3,35), Coordinate(3,36), Coordinate(4,35), Coordinate(4,36)
        ]))
    }
}

//template icon stuff
extension Templates {
    var blankIcon: some View {
        VStack(spacing: 0) {
            ForEach(0..<5) { row in
                HStack(spacing: 0) {
                    ForEach(0..<5) { col in
                        Rectangle()
                            .fill(Color.red)
                            .border(Color.black)
                    }
                }
            }
        }.drawingGroup()
    }
    
    var basicIcon: some View {
        VStack(spacing: 0) {
            ForEach(0..<5) { row in
                HStack(spacing: 0) {
                    ForEach(0..<5) { col in
                        Rectangle()
                        .fill(
                            self.aliveBasic(row, col) ? Color.green: Color.red
                        )
                            .border(Color.black)
                    }
                }
            }
        }.drawingGroup()
    }
    func aliveBasic(_ row: Int, _ col: Int)->Bool {
        return (row == 1 && (col == 1 || col == 2 || col == 3)) || (row == 2 && col == 2)
    }
    
    var gliderIcon: some View {
        VStack(spacing: 0) {
            ForEach(0..<5) { row in
                HStack(spacing: 0) {
                    ForEach(0..<5) { col in
                        Rectangle()
                        .fill(
                            self.aliveGlider(row, col) ? Color.green: Color.red
                        )
                            .border(Color.black)
                    }
                }
            }
        }.drawingGroup()
    }
    func aliveGlider(_ row: Int, _ col: Int)->Bool {
        return (col == 3 && (row == 1 || row == 2 || row == 3)) || (row == 3 && col == 2) || (col == 1 && row == 2)
    }
    
    var gliderGunIcon: some View {
        VStack(spacing: 0) {
            ForEach(0..<5) { row in
                HStack(spacing: 0) {
                    ForEach(0..<5) { col in
                        Rectangle()
                        .fill(
                            self.aliveGliderGun(row, col) ? Color.green: Color.red
                        )
                            .border(Color.black)
                    }
                }
            }
        }.drawingGroup()
    }
    func aliveGliderGun(_ row: Int, _ col: Int)->Bool {
        return (row == 2 && (col == 0 || col == 2 || col == 3)) || (col == 1 && (row == 0 || row == 4)) || (col == 2 && (row == 1 || row == 3))
    }
}
