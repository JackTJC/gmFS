//
//  SheetView.swift
//  gmFS
//
//  Created by jincaitian on 2022/5/27.
//

import SwiftUI

struct SheetView: View {
    @State var showSheet  = false
    var body: some View {
        VStack{
            Button("sheet", action: {self.showSheet.toggle()})
        }.sheet(isPresented: self.$showSheet, content: {Text("hello")})
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
