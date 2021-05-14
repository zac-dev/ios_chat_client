//
//  ChatMessage.swift
//  MyChatApp
//
//  Created by Zachary Burgess on 12/05/2021.
//

import SwiftUI

struct AuthorModel: Hashable {
    let avatar: String
    let name: String
    let id: String
}

struct ChatMessageModel : Hashable {
    let text: String
    var color: Color { isSentByCurrentUser ? .green : .blue }
    var avatar: String { author.avatar }
    
    var isSentByCurrentUser: Bool
    var author: AuthorModel
}
