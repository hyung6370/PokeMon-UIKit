//
//  PokemonWidgetBundle.swift
//  PokemonWidgetExtension
//
//  Created by Hyungjun KIM on 2/27/25.
//

import WidgetKit
import SwiftUI

@main
struct PokemonWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        PokemonWidget()
    }
}
