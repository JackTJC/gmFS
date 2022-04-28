//
//  gmFSApp.swift
//  gmFS
//
//  Created by jincaitian on 2022/2/14.
//

import SwiftUI

@main
struct gmFSApp: App {
    @StateObject private var shareService = ShareService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(shareService)
        }
    }
}
