# ios_chat_client
adaptation of https://github.com/halavins/SwiftUI-Chat 

I basiclly added a snapshot test, and a speech bubble. so far.

I have a failing UI test, where the list of messages fails to scroll to the bottom of the list when a message is added. 
I can only assume that this is due to the ScrollViewReader not being able to find the message that I want to scroll to. 
can it only find visible list tiems? (like accessability? - not sure, code examples don't mention this as a thing!).

# TODO: (not ordered)
- add networking layer to update messages from server.
- add coredata to save messages locally as a preload system so we don't have to wait for messages to come from server on first show / conversation backup.
- add push notifications to show new messages when not in application or not in related conversation.
- add websockets for server updates on current conversation.
- add user login
- add conversation selector
- add multimedia messages (images, urls, sound, videos)
