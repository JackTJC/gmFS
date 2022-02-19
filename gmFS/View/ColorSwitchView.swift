//
//  ColorSwitchView.swift
//  gmFS
//
//  Created by jincaitian on 2022/2/19.
//

import SwiftUI
struct ColorSwitchViewController: View {
    @State var connectionsLabel: String
    @State var backgroundColor: Color
    let colorService = ColorService()
    func change(color : Color) {
        backgroundColor = color
    }
    var body: some View {
        ZStack{
            backgroundColor.edgesIgnoringSafeArea(.all)
            VStack{
                Text(self.connectionsLabel)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                HStack{
                    Button(action: {
                        self.colorService.delegate = self
                        self.change(color: .yellow)
                        self.colorService.send(colorName: "yellow")
                    }) {
                        Text("yellow")
                            .foregroundColor(.yellow)
                            .fontWeight(.bold)
                            .frame(width: 60, height: 20)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color.black))
                    }
                    Button(action: {
                        self.colorService.delegate = self
                        self.change(color: .red)
                        self.colorService.send(colorName: "red")
                    }) {
                        Text("red")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .frame(width: 60, height: 20)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color.black))
                    }
                }
            }
        }
    }
}

extension ColorSwitchViewController : ColorServiceDelegate {
    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel = "Connected devices: \(connectedDevices)"
        }
    }
    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                self.change(color: .red)
            case "yellow":
                self.change(color: .yellow)
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
}
