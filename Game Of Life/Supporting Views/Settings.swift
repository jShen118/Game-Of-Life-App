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
    @Binding var liveColor: Color
    @Binding var deadColor: Color
    
    var body: some View {
        VStack {
            HStack {
                Text("Colony Name:")
                TextField("", text: self.$name)
                    .foregroundColor(.gray)
            }.padding()
            
            HStack {
                VStack {
                    Text("Living Cell Color").offset(y: 10)
                    Picker(selection: self.$liveColor, label: Text("")) {
                        Text("Red").tag(Color.red)
                        Text("Orange").tag(Color.orange)
                        Text("Yellow").tag(Color.yellow)
                        Text("Green").tag(Color.green)
                        Text("Blue").tag(Color.blue)
                        Text("Purple").tag(Color.purple)
                        Text("Black").tag(Color.black)
                        Text("Gray").tag(Color.gray)
                        Text("White").tag(Color.white)
                    }.offset(x: -4)
                }
                .padding()
                .multilineTextAlignment(.center)
                            
                VStack {
                    Text("Dead Cell Color")
                    Picker(selection: self.$deadColor, label: Text("")) {
                        Text("Red").tag(Color.red)
                        Text("Orange").tag(Color.orange)
                        Text("Yellow").tag(Color.yellow)
                        Text("Green").tag(Color.green)
                        Text("Blue").tag(Color.blue)
                        Text("Purple").tag(Color.purple)
                        Text("Black").tag(Color.black)
                        Text("Gray").tag(Color.gray)
                        Text("White").tag(Color.white)
                    }.offset(x: -3)
                }
                .padding()
                .multilineTextAlignment(.center)
            }
        }.offset(y: -34)
    }
}
