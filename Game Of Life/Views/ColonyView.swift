import SwiftUI
import Foundation
import Combine

public extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}

struct ColonyView: View {
    @Binding var colony: Colony
    @State var evolveTime = 1.0
    var evolutionTimer: Publishers.Autoconnect<Timer.TimerPublisher> {
        return Timer.publish(every: TimeInterval(evolveTime), on: .main, in: .common).autoconnect()
    }
    @State var isEvolving = false
    @State var wrap = false
    
    func onDragAt(point: CGPoint) {
        let row = Int(point.y/10)
        let col = Int(point.x/10)
        print(row,col)
        self.colony.setCellAlive(Coordinate(row, col))
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
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        return img
    }
    
    var gridView: some View {
        Image(uiImage: renderGrid()).onReceive(evolutionTimer) {_ in
            if self.isEvolving {
                if self.wrap {self.colony.evolveWrap()}
                else {self.colony.evolve()}
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
            if colony.name == "New Colony" {
                TextField("New Colony", text: self.$colony.name)
                    .foregroundColor(.gray)
            } else {
                TextField(colony.name, text: self.$colony.name)
            }
            self.gridView
            HStack {
                Button(action: {self.isEvolving.toggle()}) {
                    Text("Evolve")
                }
                Slider(value: $evolveTime, in: 0.1...2, step: 0.05)
                Toggle(isOn: $wrap) {EmptyView()}
            }
        }
    }
}
