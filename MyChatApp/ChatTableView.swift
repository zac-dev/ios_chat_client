//
//  ChatTableView.swift
//  MyChatApp
//
//  Created by Zachary Burgess on 12/05/2021.
//

import SwiftUI

struct ChatTableView: View {
    let currentUser: AuthorModel

    @State var composedMessage: String = ""
    @EnvironmentObject var chatController: ChatController

    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollProxy in
                    LazyVStack {
                        ForEach(chatController.messages, id: \.self) { msg in
                            ChatRow(chatMessage: msg)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .onChange(of: chatController.messages.count) { _ in
                        scrollProxy.scrollTo(chatController.messages.last!, anchor: .bottom)
                    }
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                to: nil,
                                                from: nil,
                                                for: nil)
            }
            .padding(.bottom, 5)
            .accessibility(identifier: "chatTable")
            VStack {
                Divider()
                HStack {
                    TextField("Message...", text: $composedMessage,
                              onCommit: {
                                  print("tick")
                                  sendMessage()
                                  // self.firstResponder = "TF1"
                              })
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .frame(minHeight: CGFloat(44))
                        .padding(.leading, 15)
                        .id("TF1")

                    /*
                     Button(action: sendMessage) {
                         Text("Send")
                             .padding(10)
                             .foregroundColor(.white)
                             .font(.footnote)
                     }
                     .frame(minHeight: CGFloat(44))
                     .background(Color.green)
                     .cornerRadius(6)
                     .padding(.trailing, 16)
                     */
                }
                .frame(minHeight: CGFloat(64))
                .padding(.bottom, 6)
            }
            .accessibility(identifier: "messageEntryControl")
        }
    }

    func sendMessage() {
        if composedMessage.isEmpty == false {
            let message = ChatMessageModel(text: composedMessage, isSentByCurrentUser: true, author: currentUser)
            chatController.sendMessage(message)
            composedMessage = ""
        }
    }
}

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ChatTableView(currentUser: AuthorModel(avatar: "A", name: "A", identity: "A"))
                .environmentObject(ChatController())
        }
    }
#endif
