//
//  ChatRow.swift
//  MyChatApp
//
//  Created by Zachary Burgess on 12/05/2021.
//

import SwiftUI

enum BubbleDirection {
    case left, right
}

struct ChatMessageBubbleBackground : View {
    
    var bubbleColor: Color
    var direction: BubbleDirection
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let padding: CGFloat = 10.0
                let origin: CGFloat = 0.0
                let frameSize: CGSize = geometry.size
                let bubbleSize: CGSize = CGSize(width: frameSize.width-padding, height: frameSize.height-padding)
                path.move(to: CGPoint(x: padding, y: padding))
                
                
                // bottom left
                path.addLine(to: CGPoint(x: padding, y: bubbleSize.height-padding))
                path.addQuadCurve(
                    to: CGPoint(x: padding*2, y: bubbleSize.height),
                    control: CGPoint(x: padding, y: bubbleSize.height)
                )
                switch direction {
                case .left:
                    // question mark
                    let questionStart = CGPoint(x: padding*2, y: bubbleSize.height)
                    let questionBottom = CGPoint(x: questionStart.x, y: bubbleSize.height+padding)
                    let questionEnd = CGPoint(x: questionStart.x+padding, y: bubbleSize.height)
                    path.addLine(to: questionStart)
                    path.addQuadCurve(
                        to: questionBottom,
                        control: CGPoint(x: questionBottom.x, y: questionBottom.y)
                    )
                    path.addQuadCurve(
                        to: questionEnd,
                        control: CGPoint(x: questionEnd.x, y: questionEnd.y)
                    )
                case .right:
                    // question mark
                    let questionStart = CGPoint(x: bubbleSize.width-(padding*1), y: bubbleSize.height)
                    let questionBottom = CGPoint(x: questionStart.x, y: bubbleSize.height+padding)
                    let questionEnd = CGPoint(x: questionStart.x-padding, y: bubbleSize.height)
                    path.addLine(to: questionStart)
                    path.addQuadCurve(
                        to: questionBottom,
                        control: CGPoint(x: questionBottom.x, y: questionBottom.y)
                    )
                    path.addQuadCurve(
                        to: questionEnd,
                        control: CGPoint(x: questionEnd.x, y: questionEnd.y)
                    )
                }
                
                // bottom right
                path.addLine(to: CGPoint(x: bubbleSize.width-padding, y: bubbleSize.height))
                path.addQuadCurve(
                    to: CGPoint(x: bubbleSize.width, y: bubbleSize.height-padding),
                    control: CGPoint(x: bubbleSize.width, y: bubbleSize.height)
                )
                
                // top right
                path.addLine(to: CGPoint(x: bubbleSize.width, y: padding))
                path.addQuadCurve(
                    to: CGPoint(x: bubbleSize.width-padding, y: origin),
                    control: CGPoint(x: bubbleSize.width, y: origin)
                )
                
                // top
                path.addLine(to: CGPoint(x: padding*2, y: origin))
                path.addQuadCurve(
                    to: CGPoint(x: padding, y: padding),
                    control: CGPoint(x: padding, y: origin)
                )
            }.fill(bubbleColor)
        }
    }
}

struct ChatRow : View {
    
    var chatMessage: ChatMessageModel
    var direction: BubbleDirection {
        chatMessage.isSentByCurrentUser ? .left : .right
    }
    var alignment: HorizontalAlignment {
        chatMessage.isSentByCurrentUser ? .leading : .trailing
    }
    var textAlignment: TextAlignment {
        chatMessage.isSentByCurrentUser ? .leading : .trailing
    }
    
    var body: some View {
        HStack {
            if !chatMessage.isSentByCurrentUser { Spacer() }
            VStack(alignment: alignment) {
                Group {
                    Text(chatMessage.text).font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(textAlignment)
                        .frame(minWidth: 50)
                        .padding(20)
                        .background(ChatMessageBubbleBackground(bubbleColor: chatMessage.color, direction: direction).padding(.top, 10))
                    Text(chatMessage.author.name)
                        .font(.footnote)
                        .padding(chatMessage.isSentByCurrentUser ? .leading : .trailing, 10)
                }
            }
            if chatMessage.isSentByCurrentUser { Spacer() }
        }
    }
}


#if DEBUG
struct ChatRow_Previews : PreviewProvider {
    
    static var previews: some View {
        List {
            ChatRow(chatMessage:  ChatMessageModel(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", isSentByCurrentUser: true, author: AuthorModel(avatar: "A", name: "You", id: "A"))).frame(maxWidth:.infinity)
            ChatRow(chatMessage: ChatMessageModel(text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isSentByCurrentUser: false, author: AuthorModel(avatar: "B", name: "Betty", id: "B"))).frame(maxWidth:.infinity)
        }.frame(maxWidth:.infinity)
    }
}
#endif
