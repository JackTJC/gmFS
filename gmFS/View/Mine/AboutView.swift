//
//  Profile.swift
//  gmFS
//
//  Created by bytedance on 2022/3/20.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            Image("about")
                .resizable()
                .frame(width: 120, height: 120)
            aboutSubLineView(header: "Designed By", content: "JincaiTian")
            aboutSubLineView(header: "Guided By", content: "WeiWang")
            aboutSubLineView(header: "Version", content: "1.0.0")
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

struct aboutSubLineView: View {
    var header = ""
    var content = ""
    var body: some View {
        HStack{
            Text(header)
            Spacer()
            Text(content)
        }
        .frame(width: 300, height: 30)
        .font(.title)
    }
}
