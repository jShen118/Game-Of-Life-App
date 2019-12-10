struct Coordinate: CustomStringConvertible, Hashable, Identifiable {
    var id: Int
    
    let row: Int
    let col: Int
    init(_ r: Int, _ c: Int) {
        row = r
        col = c
        id = r*60+c
        
    }
    
    var description: String {
        return "(\(row), \(col))"
    }
    func makeCoors()->Set<Coordinate> {
        var toRet = Set<Coordinate>()
        for r in -1...1 {
            for c in -1...1 {
                toRet.insert(Coordinate(row + r, col + c))
            }
        }
        return toRet
    }
}
