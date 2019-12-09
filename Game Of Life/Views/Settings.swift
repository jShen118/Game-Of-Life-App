//
//  Settings.swift
//  Game Of Life
//
//  Created by Joey Cohen on 12/3/19.
//  Copyright © 2019 Stulin iOS. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @State private var type = "Statistics"
    @Binding var name: String
    @Binding var liveColor: UIColor
    @Binding var deadColor: UIColor
    var wrapping: Bool
    var timer: Double
    var generationNumber: Int
    var numberLiving: Int
    
    var body: some View {
        VStack {
            if type == "Settings" {
                VStack {
                    VStack {
                        Text("Settings")
                            .font(.largeTitle)
                        
                        Picker(selection: $type, label: Text("Type")) {
                            Text("Settings").tag("Settings")
                            Text("Statistics").tag("Statistics")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                    }.offset(y: -100)
                    HStack {
                        Text("Colony Name:")
                        TextField("", text: self.$name)
                            .foregroundColor(.gray)
                    }.padding()
                    
                    HStack {
                        VStack {
                            Text("Living Cell Color").offset(y: 10)
                            Picker(selection: $liveColor, label: Text("")) {
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
                            Picker(selection: $deadColor, label: Text("")) {
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
            } else {
                VStack {
                    VStack {
                        Text("Statistics")
                            .font(.largeTitle)
                        
                        Picker(selection: $type, label: Text("Type")) {
                            Text("Settings").tag("Settings")
                            Text("Statistics").tag("Statistics")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                    }.offset(y: -100)
                    HStack {
                        Text("Generation Number: \(generationNumber)")
                          .padding()
                        Spacer()
                    }
                    HStack {
                        Text("\(numberLiving) cells out of 3,600 cells")
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Text("Wrapping:")
                        if wrapping {
                            Text("Enabled")
                        } else {
                            Text("Disabled")
                        }
                        Spacer()
                    }.padding()
                    HStack {
                        Text("Evolution Speed: \(timer) evolutions per second")
                            .padding()
                        Spacer()
                    }
                }.offset(y: -100)
            }
        }
    }
}

//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Settings(name: "joey", liveColor: .blue, deadColor: .red, wrapping: true, timer: 1.0, generationNumber: 5, numberLiving: 100)
//    }
//}
