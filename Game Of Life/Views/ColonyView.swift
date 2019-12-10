import SwiftUI
import Foundation
import Combine

struct Checkerboard: Shape {
    @Binding var colony: Colony

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(colony.size)
        let columnSize = rect.width / CGFloat(colony.size)
        
        let rect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        path.addRect(rect)

        // loop over all rows and columns, making alternating squares colored
        for coord in colony.cellsArray() {
            // this square should be colored; add a rectangle here
            let startX = columnSize * CGFloat(coord.col)
            let startY = rowSize * CGFloat(coord.row)

            let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
            path.addRect(rect)
                
        }

        return path
    }
}



struct ColonyView: View {
    @Binding var colony: Colony
    @State var evolveTime = 1.0
    var evolutionTimer: Publishers.Autoconnect<Timer.TimerPublisher> {
        return Timer.publish(every: TimeInterval(evolveTime), on: .main, in: .common).autoconnect()
    }
    @State var isEvolving = false
    @State var isOpenSettings = false
    @State var wrap = false
    
    var gridLength: CGFloat
    var cellLength: CGFloat {
        return gridLength/60
    }
    
    func onDragAt(point: CGPoint) {
        print(point)
        if point.x < 0 || point.y < 0 || point.x >= gridLength || point.y >= gridLength {
            return
        }
        let row = Int(point.y/cellLength)
        let col = Int(point.x/cellLength)
        self.colony.toggleLife(Coordinate(row, col))
    }
    
    func bruh(frameSize: Int)->some View {
        let cellSize: CGFloat = CGFloat(frameSize / colony.size)
        
        var background = Path()
        let rect = CGRect(x: 0, y: 0, width: frameSize, height: frameSize)
        background.addRect(rect)
        
        var grid = Path()
        for row in 0..<colony.size {
            grid.move(to: CGPoint(x:0, y:CGFloat(row)*cellSize))
            grid.addLine(to: CGPoint(x: CGFloat(frameSize), y:CGFloat(row)*cellSize))
        }
        for col in 0..<colony.size {
            grid.move(to: CGPoint(x: CGFloat(col)*cellSize, y: 0))
            grid.addLine(to: CGPoint(x: CGFloat(col)*cellSize, y: CGFloat(frameSize)))
        }
        
        var cellsPath = Path()
        
        for coord in colony.cellsArray() {
            // this square should be colored; add a rectangle here
            let startX = cellSize * CGFloat(coord.col)
            let startY = cellSize * CGFloat(coord.row)

            let rect = CGRect(x: startX, y: startY, width: cellSize, height: cellSize)
            cellsPath.addRect(rect)
                
        }
        
        return ZStack {
            background.fill(self.colony.deadColor)
            grid.stroke()
            cellsPath.fill(self.colony.liveColor)
        }
    }
    
     func renderGrid()->UIImage {
         let renderer = UIGraphicsImageRenderer(size: CGSize(width: 600, height: 600))
         let img = renderer.image { ctx in
             ctx.cgContext.setFillColor(UIColor.blue.cgColor)

             let rectangle = CGRect(x: 0, y: 0, width: 600, height: 600)
             ctx.cgContext.addRect(rectangle)

             for row in 0..<60 {
                 for col in 0..<60 {
                     let rectangle = CGRect(x: col*10, y: row*10, width: 10, height: 10)
                     ctx.cgContext.addRect(rectangle)
                     let color = colony.isCellAlive(Coordinate(row, col)) ? UIColor.green : UIColor.red

                     ctx.cgContext.setFillColor(color.cgColor)
                     ctx.cgContext.addRect(rectangle)
                     ctx.cgContext.drawPath(using: .fillStroke)
                 }
             }
         }
         return img
     }

     var gridView: some View {
         Image(uiImage: renderGrid()).onReceive(evolutionTimer) {_ in
             if self.isEvolving {
                self.colony.evolve(self.wrap)
             }
         }.drawingGroup()
         .gesture(DragGesture(minimumDistance: 0)
             .onChanged { value in
                 self.onDragAt(point: value.location)
         }
             .onEnded { value in
             }
         )
     }
     
    
    var body: some View {
        VStack {
            HStack {
                Toggle("Wrapping", isOn: self.$wrap)
                    .frame(width: 135)
                    .padding()
                
                if colony.name == "New Colony" {
                    TextField("New Colony", text: self.$colony.name)
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .offset(x: -50)
                } else {
                    TextField(colony.name, text: self.$colony.name)
                        .font(.largeTitle)
                        .padding()
                        .multilineTextAlignment(.center)
                        .offset(x: -50)
                }
                                
                Button(action: {self.isOpenSettings.toggle()}) {
                    Image(systemName: "gear")
                        .resizable()
                        .foregroundColor(.black)
                }
                .frame(width: 23, height: 23, alignment: .topTrailing)
                .padding()
                .sheet(isPresented: $isOpenSettings) {
                    Controller(name: self.$colony.name, liveColor: self.$colony.liveColor, deadColor: self.$colony.deadColor, wrap: self.$wrap, evolutionTime: self.$evolveTime, generationNumber: self.$colony.generationNumber, numberLiving: self.colony.numberLiving)
                }
            }
            //self.gridView
            /*
            ZStack {
                ForEach(0..<60) { row in
                    ForEach(0..<60) { col in
                        Rectangle().foregroundColor(self.colony.isCellAlive(Coordinate(row, col)) ? self.colony.liveColor: self.colony.deadColor)
                            .border(Color.black, width: 1)
                            .offset(x: (CGFloat(col)-30)*self.cellLength, y: (CGFloat(row)-30)*self.cellLength)
                            .frame(width: self.cellLength, height: self.cellLength)
                            .onTapGesture {self.colony.toggleLife(Coordinate(row, col))}
                    }
                }
            }.frame(width: gridLength+10, height: gridLength+10).drawingGroup()
            .onReceive(evolutionTimer) { _ in
                if self.isEvolving {self.colony.evolve(self.wrap)}
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    self.onDragAt(point: value.location)
                })*/
            
            bruh(frameSize: 600)
            .frame(width: 600, height: 600).gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    self.onDragAt(point: value.location)
            }   // 4.
                .onEnded { value in
                }
            )
            
 
            VStack {
                HStack {
                    Text("Fast")
                    Slider(value: $evolveTime, in: 0.1...2, step: 0.05)
                        .frame(width: 375)
                    Text("Slow")
                }
                
                VStack {
                    if isEvolving {
                        Button(action: {self.isEvolving.toggle()}) {
                            Image(systemName: "pause.fill")
                                 .resizable()
                                .foregroundColor(.black)
                        }.frame(width: 25, height: 25, alignment: .center)
                        
                    } else {
                        Button(action: {self.isEvolving.toggle()}) {
                            Image(systemName: "play.fill")
                                 .resizable()
                                .foregroundColor(.black)
                        }.frame(width: 25, height: 25, alignment: .center)
                    }
                    Text("Evolve")
                }
            }.multilineTextAlignment(.center)
        }
    }
}


