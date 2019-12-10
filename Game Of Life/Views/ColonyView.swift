import SwiftUI
import Foundation
import Combine

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
        if point.x < 0 || point.y < 0 || point.x >= gridLength || point.y >= gridLength {
            return
        }
        let row = Int(point.y/cellLength)
        let col = Int(point.x/cellLength)
        //print(row,col)
        self.colony.toggleLife(Coordinate(row, col))
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
         }   // 4.
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
            self.gridView
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


