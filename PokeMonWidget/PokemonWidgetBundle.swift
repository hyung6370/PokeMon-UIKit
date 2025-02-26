//
//  PokemonWidgetBundle.swift
//  PokemonWidget
//
//  Created by Hyungjun KIM on 2/26/25.
//

import WidgetKit
import SwiftUI

@main
struct PokemonWidgetBundle: WidgetBundle {
    var body: some Widget {
        PokemonWidget()
        PokemonWidgetControl()
        PokemonWidgetLiveActivity()
    }
}
