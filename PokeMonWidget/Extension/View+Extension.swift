//
//  View+Extension.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/27/25.
//

import SwiftUI

extension View {
    func widgetBackground(_ color: Color) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                color
            }
        } else {
            return background(color)
        }
    }
}
