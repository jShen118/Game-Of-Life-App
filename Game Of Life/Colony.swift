// colony.swift

struct Colony: CustomStringConvertible, Identifiable {
    var name: String = "No Name"
    var generationNumber = 0
    var id: Int
    static var nextID = 0
    let size: Int
    var data = [Bool]()
    
    init(_ name: String, _ size: Int = 10, _ coors: [Coordinate] = [Coordinate]()) {
        self.id = Colony.nextID
        self.name = name
        self.size = size
        self.clear()
        Colony.nextID += 1
    }
    
    func convertToCoordinates(_ x: Double, _ y: Double)-> Coordinate {
        return Coordinate(Int(x/11.666667), Int(y/11.666667))
    }
    
    mutating func resetColony() {
        self.data = [Bool].init(repeating: false, count: size*size)
    }
    
    mutating func setColonyFromCoors(_ cells: [Coordinate]) {
        self.clear()
        for cell in cells {
            setCellAlive(cell)
        }
    }
    mutating func clear() {
        self.data = [Bool].init(repeating: false, count: size*size)
    }
    mutating func setName(name: String) {self.name = name}
    
    func getIndex(_ c: Coordinate)->Int {
        return c.row*size+c.col
    }
    
    mutating func setCellAlive(_ c: Coordinate) {
        self.data[getIndex(c)] = true
    }
    mutating func setCellDead(_ c: Coordinate) {
        self.data[getIndex(c)] = true
    }
    mutating func toggleLife(_ c: Coordinate) {
        let val = self.data[getIndex(c)]
        self.data[getIndex(c)] = !val
    }
    func isCellAlive(_ c: Coordinate)-> Bool {
        return self.data[getIndex(c)]
    }
    var numberLivingCells: Int {
        var num = 0
        for c in self.data {
            if c {
                num+=1
            }
        }
        return num
    }
    var description: String {
        var toRet = "Generation #\(generationNumber)\n"
        for r in 0..<size {
            for c in 0..<size {
                if isCellAlive(Coordinate(r, c)) {toRet += "*"}
                else {toRet += " "}
            }
            toRet += "\n"
        }
        return toRet
    }
    
    func isInBounds(_ c: Coordinate)->Bool {
        return c.row >= 0 && c.row < size && c.col >= 0 && c.col < size
    }
    
    //returns true if coordinate will be alive next generation, false if it won't be

}

// Swift modulo works weirdly with negative numbers
//
// -3 % 8 = -3
// _modulo(-3, 8) = 5

func _modulo(_ x:Int, _ y:Int) -> Int {
    if x<0 {
        return y-(-x%y)
    }
    return x%y
}

//evolve() and its helpers
extension Colony {
    func cellvalue_nowrap(_ row: Int, _ col: Int)->Int {
        if row < 0 || col < 0 || row >= size || col >= size {
            return 0
        }
        return isCellAlive(Coordinate(row, col)) ? 1 : 0
    }
    
    mutating func evolve() {
        generationNumber += 1
        var buffer = [Bool].init(repeating: false, count: size*size)
        
        for row in 0..<size {
            for col in 0..<size {
                var neighbors = -1 // automatically exclude own cell
                for dr in -1...1 {
                    for dc in -1...1 {
                        neighbors+=cellvalue_nowrap(row+dr, col+dc)
                    }
                }
                
                if neighbors == 3 || (neighbors == 2 && isCellAlive(Coordinate(row, col))) {
                    buffer[getIndex(Coordinate(row, col))] = true
                }
            }
        }
    }
}

//evolveWrap() and its helpers
extension Colony {
    func cellvalue_wrap(_ row: Int, _ col: Int)->Int {
        return isCellAlive(Coordinate(_modulo(row, size), _modulo(col, size))) ? 1 : 0
    }
    
    mutating func evolveWrap() {
        generationNumber += 1
        var buffer = [Bool].init(repeating: false, count: size*size)
        
        for row in 0..<size {
            for col in 0..<size {
                var neighbors = -1 // automatically exclude own cell
                for dr in -1...1 {
                    for dc in -1...1 {
                        neighbors+=cellvalue_wrap(row+dr, col+dc)
                    }
                }
                
                if neighbors == 3 || (neighbors == 2 && isCellAlive(Coordinate(row, col))) {
                    buffer[getIndex(Coordinate(row, col))] = true
                }
            }
        }
    }
}



