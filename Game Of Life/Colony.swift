// colony.swift
import SwiftUI
import Foundation
/*
struct Colony: CustomStringConvertible, Identifiable {
    var name: String = "No Name"
    var generationNumber = 0
    var id: Int
    static var nextID = 0
    let size: Int
    var data = [Bool]()
    var liveColor = UIColor.green
    var deadColor = UIColor.red
    
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
                var neighbors = 0
                for dr in -1...1 {
                    for dc in -1...1 {
                        if dr == 0 && dc == 0 {
                            continue  // automatically exclude own cell
                        }
                        neighbors+=cellvalue_nowrap(row+dr, col+dc)
                    }
                }
                
                if neighbors == 3 || (neighbors == 2 && isCellAlive(Coordinate(row, col))) {
                    buffer[getIndex(Coordinate(row, col))] = true
                }
            }
        }
        data = buffer
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
*/

import Foundation
struct Colony: CustomStringConvertible, Identifiable {
     var name: String = "No Name"
       var generationNumber = 0
       var id: Int
       static var nextID = 0
       let size: Int
       var oldCoors = Set<Coordinate>()
       var newCoors = Set<Coordinate>()
       var liveColor = Color.green
       var deadColor = Color.red
    
    init(_ name: String, _ size: Int = 10, _ coors: [Coordinate] = [Coordinate]()) {
        self.id = Colony.nextID
        self.name = name
        self.size = size
        self.oldCoors = Set(coors)
        Colony.nextID += 1
    }
    
    mutating func setColonyFromCoors(_ cells: [Coordinate]) {
        oldCoors =  Set(cells)
    }
    mutating func setName(name: String) {self.name = name}
    mutating func clear() {
        oldCoors = Set<Coordinate>()
        newCoors = Set<Coordinate>()
    }
    mutating func setCellAlive(_ coor: Coordinate) {
        oldCoors.insert(coor)
    }
    mutating func setCellDead(_ coor: Coordinate) {
        oldCoors.remove(coor)
    }
    mutating func toggleLife(_ coor: Coordinate) {
        if isCellAlive(coor) {setCellDead(coor)}
        else {setCellAlive(coor)}
    }
    func isCellAlive(_ coor: Coordinate)-> Bool {
        return oldCoors.contains(coor)
    }
    var numberLiving: Int {return oldCoors.count}
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
    
    mutating func evolve(_ wrap: Bool) {
        if wrap {evolveWrap()}
        else {evolveNoWrap()}
    }
}

//evolve() and its helpers
extension Colony {
    mutating func evolveNoWrap() {
        generationNumber += 1
        let toCheck = cellsToCheck()
        for c in toCheck {
            let n = numSurround(c)
            if n == 3 || (n == 2 && oldCoors.contains(c)) {
                newCoors.insert(c)
            }
        }
        oldCoors = newCoors
        newCoors = Set<Coordinate>()
        print(description)
    }
    
    func cellsToCheck()->Set<Coordinate> {
        var toRet = Set<Coordinate>()
        toRet = oldCoors.map{$0.makeCoors()}
            .reduce(toRet, {$0.union($1)})
            .filter{isInBounds($0)}
        return toRet
    }
    
    
    func numSurround(_ c: Coordinate)->Int {
        if oldCoors.contains(c) {
            //reason for this if and return is that we don't want to count the cell itself when we count how many cells surround it
            return oldCoors.intersection(c.makeCoors()).count - 1
        }
        return oldCoors.intersection(c.makeCoors()).count
    }
}

//evolveWrap() and its helpers
extension Colony {
    mutating func evolveWrap() {
        generationNumber += 1
        let toCheck = cellsToCheckWrap()
        for c in toCheck {
            let n = numSurroundWrap(c)
            if n == 3 || (n == 2 && oldCoors.contains(c)) {
                newCoors.insert(c)
            }
        }
        oldCoors = newCoors
        newCoors = Set<Coordinate>()
        print(description)
    }
    
    //translates an out-of-bounds coordinate into one that is in bounds
    func wrap(_ c: Coordinate)->Coordinate {
        var newCoorRow = c.row
        var newCoorCol = c.col
        if c.row < 0 {newCoorRow = size - 1}
        if c.row >= size {newCoorRow = 0}
        if c.col < 0 {newCoorCol = size - 1}
        if c.col >= size {newCoorCol = 0}
        return Coordinate(newCoorRow, newCoorCol)
    }
    
    func cellsToCheckWrap()->Set<Coordinate> {
        var toRet = Set<Coordinate>()
        toRet = oldCoors.map{$0.makeCoors()}
            .reduce(toRet, {$0.union($1)})
        
        for c in toRet {
            if !isInBounds(c) {
                toRet.remove(c)
                toRet.insert(wrap(c))
            }
        }
        return toRet
    }
    
    func numSurroundWrap(_ c: Coordinate)->Int {
        var surroundingCoors = c.makeCoors()
        for c in surroundingCoors {
            if !isInBounds(c) {
                surroundingCoors.remove(c)
                surroundingCoors.insert(wrap(c))
            }
        }
        if oldCoors.contains(c) {
            return oldCoors.intersection(surroundingCoors).count - 1
        }
        return oldCoors.intersection(surroundingCoors).count
    }
}


