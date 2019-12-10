//
//  Controller.swift
//  Game Of Life
//
//  Created by Joshua Shen on 12/9/19.
//  Copyright © 2019 Stulin iOS. All rights reserved.
//

import SwiftUI

struct Controller: View {
    @State private var type = "Settings"
    @Binding var name: String
    @Binding var liveColor: Color
    @Binding var deadColor: Color
    @Binding var wrap: Bool
    @Binding var evolutionTime: Double
    @Binding var generationNumber: Int
    var numberLiving: Int
    
    var body: some View {
        VStack {
            Text(self.type)
                .font(.largeTitle)
            
            Picker(selection: self.$type, label: Text("Type")) {
                Text("Settings").tag("Settings")
                Text("Statistics").tag("Statistics")
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 150)
            
            if type == "Settings" {
                Settings(name: self.$name, liveColor: self.$liveColor, deadColor: self.$deadColor)
                    .animation(.easeInOut)
                    .offset(y: 50)
                Spacer()
                    .frame(height: -83)
            } else {
                Statistics(wrap: self.wrap, evolutionTime: self.evolutionTime, generationNumber: self.generationNumber, numberLiving: self.numberLiving)
                    .animation(.easeInOut)
                    .offset(y: 117)
                Spacer()
                    .frame(height: 50)
            }
        }.offset(y: -100)
    }
}
