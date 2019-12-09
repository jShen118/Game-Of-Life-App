//
//  Statistics.swift
//  Game Of Life
//
//  Created by Joey Cohen on 12/9/19.
//  Copyright © 2019 Stulin iOS. All rights reserved.
//

import SwiftUI

struct Statistics: View {
    @Binding var wrapping: Bool
    @Binding var timer: Double
    @Binding var generationNumber: Int
    @Binding var numberLiving: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("Generation Number: \(self.generationNumber)")
                  .padding()
                Spacer()
            }
            HStack {
                Text("\(self.numberLiving) cells out of 3,600 cells")
                    .padding()
                Spacer()
            }
            HStack {
                Text("Wrapping:")
                if self.wrapping {
                    Text("Enabled")
                } else {
                    Text("Disabled")
                }
                Spacer()
            }.padding()
            HStack {
                Text("Evolution Speed: \(self.timer) evolutions per second")
                    .padding()
                Spacer()
            }
        }.offset(y: -100)
    }
}
