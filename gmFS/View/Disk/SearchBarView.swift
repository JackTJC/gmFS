//
//  SearchBarView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/20.
//

import Foundation
import SwiftUI

struct SearchBarView:UIViewRepresentable{
    @Binding var text:String
    func makeUIView(context: Context) -> UISearchBar {
        let searchbar = UISearchBar(frame: .zero)
        return searchbar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text=text
    }
    
    typealias UIViewType = UISearchBar
    
    
}
