//
//  LucasWidGetLiveActivity.swift
//  LucasWidGet
//
//  Created by Lucas Pontes on 31/10/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LucasWidGetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LucasWidGetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LucasWidGetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LucasWidGetAttributes {
    fileprivate static var preview: LucasWidGetAttributes {
        LucasWidGetAttributes(name: "World")
    }
}

extension LucasWidGetAttributes.ContentState {
    fileprivate static var smiley: LucasWidGetAttributes.ContentState {
        LucasWidGetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LucasWidGetAttributes.ContentState {
         LucasWidGetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: LucasWidGetAttributes.preview) {
   LucasWidGetLiveActivity()
} contentStates: {
    LucasWidGetAttributes.ContentState.smiley
    LucasWidGetAttributes.ContentState.starEyes
}
