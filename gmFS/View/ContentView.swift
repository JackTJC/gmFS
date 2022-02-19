//
//  ContentView.swift
//  gmFS
//
//  Created by jincaitian on 2022/2/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ColorSwitchViewController(connectionsLabel: "123", backgroundColor: .blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
