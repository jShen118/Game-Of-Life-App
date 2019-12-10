//
//  Statistics.swift
//  Game Of Life
//
//  Created by Joshua Shen on 12/9/19.
//  Copyright © 2019 Stulin iOS. All rights reserved.
//

import SwiftUI

struct Statistics: View {
    var wrap: Bool
    var evolutionTime: Double
    var generationNumber: Int
    var numberLiving: Int
    
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
                if self.wrap {
                    Text("Enabled")
                } else {
                    Text("Disabled")
                }
                Spacer()
            }.padding()
            HStack {
                Text("Evolution Speed: \(self.evolutionTime) seconds per evolution")
                    .padding()
                Spacer()
            }
        }.offset(y: -100)
    }
}
