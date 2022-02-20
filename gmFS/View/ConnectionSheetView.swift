//
//  ConnectionSheetView.swift
//  gmFS
//
//  Created by bytedance on 2022/2/20.
//

import SwiftUI

struct ConnectionSheetView: View {
    var body: some View {
        VStack{
            Text("Available Device").font(.title)
            List{
                Text("Device 1")
                Text("Device 2")
                Text("Device 3")
            }
        }
    }
}

struct ConnectionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionSheetView()
    }
}
