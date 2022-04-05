//
//  ProfileRow.swift
//  gmFS
//
//  Created by bytedance on 2022/3/27.
//

import SwiftUI

struct AboutRowView: View {
    var body: some View {
        HStack {
            Image("puzzle")
            Text("About")
            Spacer()
            Image(systemName: "chevron.forward")
        }
        .frame(width: 300, height: 50)
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        AboutRowView()
    }
}
