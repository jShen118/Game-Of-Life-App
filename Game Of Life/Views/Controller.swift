//
//  Controller.swift
//  Game Of Life
//
//  Created by Joey Cohen on 12/9/19.
//  Copyright © 2019 Stulin iOS. All rights reserved.
//

import SwiftUI

struct Controller: View {
    @State private var type = "Settings"
    @Binding var name: String
    @Binding var liveColor: UIColor
    @Binding var deadColor: UIColor
    @State var wrapping: Bool
    @State var timer: Double
    @State var generationNumber: Int
    @State var numberLiving: Int
    
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
                Statistics(wrapping: self.$wrapping, timer: self.$timer, generationNumber: self.$generationNumber, numberLiving: self.$numberLiving)
                    .animation(.easeInOut)
                    .offset(y: 117)
                Spacer()
                    .frame(height: 50)
            }
        }.offset(y: -100)
    }
}
