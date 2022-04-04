//
//  ChgPasswdRow.swift
//  gmFS
//
//  Created by bytedance on 2022/3/27.
//

import SwiftUI

struct ChgPasswdRow: View {
    var body: some View {
        HStack {
            Image("key")
            Text("Change Password")
            Spacer()
            Image(systemName: "chevron.forward")
        }
    }
}

struct ChgPasswdRow_Previews: PreviewProvider {
    static var previews: some View {
        ChgPasswdRow()
    }
}
