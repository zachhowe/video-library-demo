//
//  VideoLibraryApp.swift
//  VideoLibrary
//
//  Created by Zach Howe on 11/17/23.
//

import SwiftUI

@main
struct VideoLibraryApp: App {
    var model = ContentModel()

    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
        .windowResizability(.contentSize)
    }
}
