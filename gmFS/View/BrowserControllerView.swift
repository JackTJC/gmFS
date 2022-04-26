//
//  BrowserControllerView.swift
//  gmFS
//
//  Created by jincaitian on 2022/4/20.
//

import Foundation
import SwiftUI
import MultipeerConnectivity

struct BrowserView:UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> MCBrowserViewController {
        let controller = MCBrowserViewController(browser: <#T##MCNearbyServiceBrowser#>, session: <#T##MCSession#>)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MCBrowserViewController, context: Context) {
    }
    
    typealias UIViewControllerType = MCBrowserViewController
    
}
