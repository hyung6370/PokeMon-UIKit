//
//  PokeMonWidgetBundle.swift
//  PokeMonWidget
//
//  Created by Hyungjun KIM on 2/25/25.
//

import WidgetKit
import SwiftUI

@main
struct PokeMonWidgetBundle: WidgetBundle {
    var body: some Widget {
        PokeMonWidget()
        PokeMonWidgetControl()
        PokeMonWidgetLiveActivity()
    }
}
