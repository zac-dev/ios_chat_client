//
//  ChatTableView.swift
//  MyChatApp
//
//  Created by Zachary Burgess on 12/05/2021.
//

import SwiftUI

class ScrollToModel: ObservableObject {
    enum Action {
        case end
        case top
    }
    @Published var direction: Action? = nil
}

struct ChatTableView : View {
    let currentUser: AuthorModel
    
    @State var composedMessage: String = ""
    @StateObject var vm = ScrollToModel()
    @EnvironmentObject var chatController: ChatController
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { sp in
                    LazyVStack {
                        ForEach(chatController.messages, id: \.self) { msg in
                            ChatRow(chatMessage: msg)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .onReceive(vm.$direction) { action in
                        guard !chatController.messages.isEmpty else { return }
                        withAnimation {
                            print("Kayay!: \(chatController.messages.endIndex)")
                            sp.scrollTo(chatController.messages.last!, anchor: .bottom)
                        }
                    }
                }
            }
            .padding(.bottom, 5)
            .accessibility(identifier: "chatTable")
            VStack {
                Divider()
                HStack {
                    TextField("Message...", text: $composedMessage)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .frame(minHeight: CGFloat(44))
                        .padding(.leading, 15)
                    
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
            vm.direction = .end
            composedMessage = ""
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ChatTableView(currentUser: AuthorModel(avatar: "A", name: "A", id: "A"))
            .environmentObject(ChatController())
    }
}
#endif
