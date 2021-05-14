//
//  ChatController.swift
//  MyChatApp
//
//  Created by Zachary Burgess on 12/05/2021.
//

import Combine
import SwiftUI

class ChatController : ObservableObject {
    
    var didChange = PassthroughSubject<Void, Never>()
    
    // Populate form server call/database later
    @Published var messages = [
        ChatMessageModel(text: "Hello world", isSentByCurrentUser: true, author: AuthorModel(avatar: "A", name: "Anthony", id: "A")),
        ChatMessageModel(text: "Hello world", isSentByCurrentUser: false, author: AuthorModel(avatar: "B", name: "Betty", id: "B")),
        ChatMessageModel(text: "Hello world", isSentByCurrentUser: false, author: AuthorModel(avatar: "C", name: "Charles", id: "C")),
        ChatMessageModel(text: "Hello world", isSentByCurrentUser: false, author: AuthorModel(avatar: "D", name: "Dennis", id: "D")),
        ChatMessageModel(text: "Hello world", isSentByCurrentUser: false, author: AuthorModel(avatar: "E", name: "Enid", id: "E")),
        ChatMessageModel(text: "Hello world", isSentByCurrentUser: false, author: AuthorModel(avatar: "F", name: "Fank", id: "F")),
        ChatMessageModel(text: "Hello world", isSentByCurrentUser: false, author: AuthorModel(avatar: "G", name: "Gale", id: "G"))
    ]
    
    func sendMessage(_ chatMessage: ChatMessageModel) {
        messages.append(chatMessage)
        // send message to server here later
        didChange.send(())
    }
}
