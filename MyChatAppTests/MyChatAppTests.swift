//
//  MyChatAppTests.swift
//  MyChatAppTests
//
//  Created by Zachary Burgess on 12/05/2021.
//

@testable import MyChatApp
import SnapshotTesting
import SwiftUI
import XCTest

class MyChatAppTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    // swiftlint:disable line_length
    func testChatRowSnapshots() throws {
        var testView: some View {
            List {
                ChatRow(chatMessage: ChatMessageModel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", isSentByCurrentUser: true, author: AuthorModel(avatar: "A", name: "You", id: "A"))).frame(maxWidth: .infinity)
                ChatRow(chatMessage: ChatMessageModel(text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isSentByCurrentUser: false, author: AuthorModel(avatar: "B", name: "Betty", id: "B")))
            }.listStyle(SidebarListStyle()).frame(maxWidth: .infinity)
        }
        assertSnapshot(matching: testView, as: .image)
    }

    // swiftlint:enable line_length
    func testChatTableViewSnapshots() throws {
        var testView: some View {
            ChatTableView(currentUser: AuthorModel(avatar: "A", name: "A", id: "A"))
                .environmentObject(ChatController())
        }
        assertSnapshot(matching: testView, as: .image)
    }
}
