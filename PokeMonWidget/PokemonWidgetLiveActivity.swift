//
//  PokemonWidgetLiveActivity.swift
//  PokemonWidget
//
//  Created by Hyungjun KIM on 2/26/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PokemonWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PokemonWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PokemonWidgetAttributes.self) { context in
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

extension PokemonWidgetAttributes {
    fileprivate static var preview: PokemonWidgetAttributes {
        PokemonWidgetAttributes(name: "World")
    }
}

extension PokemonWidgetAttributes.ContentState {
    fileprivate static var smiley: PokemonWidgetAttributes.ContentState {
        PokemonWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: PokemonWidgetAttributes.ContentState {
         PokemonWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: PokemonWidgetAttributes.preview) {
   PokemonWidgetLiveActivity()
} contentStates: {
    PokemonWidgetAttributes.ContentState.smiley
    PokemonWidgetAttributes.ContentState.starEyes
}
