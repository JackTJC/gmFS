//
//  ProfileRow.swift
//  gmFS
//
//  Created by bytedance on 2022/3/27.
//

import SwiftUI

struct ProfileRow: View {
    var body: some View {
        HStack {
            Image("puzzle")
            Text("Profile")
            Spacer()
            Image(systemName: "chevron.forward")
        }
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow()
    }
}
