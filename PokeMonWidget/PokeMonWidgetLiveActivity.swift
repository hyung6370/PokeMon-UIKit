//
//  PokeMonWidgetLiveActivity.swift
//  PokeMonWidget
//
//  Created by Hyungjun KIM on 2/25/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PokeMonWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PokeMonWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PokeMonWidgetAttributes.self) { context in
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

extension PokeMonWidgetAttributes {
    fileprivate static var preview: PokeMonWidgetAttributes {
        PokeMonWidgetAttributes(name: "World")
    }
}

extension PokeMonWidgetAttributes.ContentState {
    fileprivate static var smiley: PokeMonWidgetAttributes.ContentState {
        PokeMonWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: PokeMonWidgetAttributes.ContentState {
         PokeMonWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: PokeMonWidgetAttributes.preview) {
   PokeMonWidgetLiveActivity()
} contentStates: {
    PokeMonWidgetAttributes.ContentState.smiley
    PokeMonWidgetAttributes.ContentState.starEyes
}
