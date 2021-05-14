//
//  MyChatAppApp.swift
//  MyChatApp
//
//  Created by Zachary Burgess on 12/05/2021.
//

import SwiftUI

@main
struct MyChatApp: App {
    let controller = ChatController()
    var body: some Scene {
        WindowGroup {
            ChatTableView(currentUser: AuthorModel(avatar: "A", name: "Anthony", identity: "A"))
                .environmentObject(controller)
        }
    }
}
