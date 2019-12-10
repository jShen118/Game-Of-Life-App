// colony.swift
import SwiftUI
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


