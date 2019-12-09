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
                        Text("Red").tag(UIColor.red)
                        Text("Orange").tag(UIColor.orange)
                        Text("Yellow").tag(UIColor.yellow)
                        Text("Green").tag(UIColor.green)
                        Text("Blue").tag(UIColor.blue)
                        Text("Purple").tag(UIColor.purple)
                        Text("Black").tag(UIColor.black)
                        Text("Gray").tag(UIColor.gray)
                        Text("White").tag(UIColor.white)
                    }.offset(x: -4)
                }
                .padding()
                .multilineTextAlignment(.center)
                            
                VStack {
                    Text("Dead Cell Color")
                    Picker(selection: self.$deadColor, label: Text("")) {
                        Text("Red").tag(UIColor.red)
                        Text("Orange").tag(UIColor.orange)
                        Text("Yellow").tag(UIColor.yellow)
                        Text("Green").tag(UIColor.green)
                        Text("Blue").tag(UIColor.blue)
                        Text("Purple").tag(UIColor.purple)
                        Text("Black").tag(UIColor.black)
                        Text("Gray").tag(UIColor.gray)
                        Text("White").tag(UIColor.white)
                    }.offset(x: -3)
                }
                .padding()
                .multilineTextAlignment(.center)
            }
        }.offset(y: -34)
    }
}

//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings(name: "joey", liveColor: .blue, deadColor: .red, wrapping: true, timer: 1.0, generationNumber: 5, numberLiving: 100)
//    }
//}
