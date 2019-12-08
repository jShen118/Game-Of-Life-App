//
//  Settings.swift
//  Game Of Life
//
//  Created by Joey Cohen on 12/3/19.
//  Copyright © 2019 Stulin iOS. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @Binding var name: String
    @Binding var liveColor: UIColor
    @Binding var deadColor: UIColor
    var generationNumber: Int
    var numberLiving: Int
    //var colorStrings : [String] = ["red", "orange", "yellow", "green", "blue", "purple", "black", "gray", "white"]
    
    var body: some View {
        VStack {
            TextField("Colony Name", text: self.$name)
            HStack {
                Picker(selection: $liveColor, label: Text("Living Cell Color")) {
                    Text("red").tag(UIColor.red)
                    Text("orange").tag(UIColor.orange)
                    Text("yellow").tag(UIColor.yellow)
                    Text("green").tag(UIColor.green)
                    Text("blue").tag(UIColor.blue)
                    Text("purple").tag(UIColor.purple)
                    Text("black").tag(UIColor.black)
                    Text("gray").tag(UIColor.gray)
                    Text("white").tag(UIColor.white)
                }
                Picker(selection: $deadColor, label: Text("Dead Cell Color")) {
                   Text("red").tag(UIColor.red)
                   Text("orange").tag(UIColor.orange)
                   Text("yellow").tag(UIColor.yellow)
                   Text("green").tag(UIColor.green)
                   Text("blue").tag(UIColor.blue)
                   Text("purple").tag(UIColor.purple)
                   Text("black").tag(UIColor.black)
                   Text("gray").tag(UIColor.gray)
                   Text("white").tag(UIColor.white)
                }
            }
        }.navigationBarTitle("Settings")
    }
}
