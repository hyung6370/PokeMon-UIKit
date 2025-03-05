//
//  ThemeColor.swift
//  PokeMon-UIKit
//
//  Created by Hyungjun KIM on 2/18/25.
//

import UIKit
import SwiftUI

struct ThemeColor {
    static let primary  = UIColor(hex: "D21312")
    static let normal   = UIColor(hex: "D8D9DA")
    static let fighting = UIColor(hex: "F28705")
    static let flying   = UIColor(hex: "95C8FF")
    static let poison   = UIColor(hex: "9652D9")
    static let ground   = UIColor(hex: "AA7939")
    static let rock     = UIColor(hex: "BCB889")
    static let bug      = UIColor(hex: "9FA423")
    static let ghost    = UIColor(hex: "6E4570")
    static let steel    = UIColor(hex: "6AAED3")
    static let fire     = UIColor(hex: "FF612B")
    static let water    = UIColor(hex: "2892FF")
    static let grass    = UIColor(hex: "47BF26")
    static let electric = UIColor(hex: "F2CB05")
    static let psychic  = UIColor(hex: "FF637F")
    static let ice      = UIColor(hex: "62DFFF")
    static let dragon   = UIColor(hex: "5462D6")
    static let dark     = UIColor(hex: "4F4747")
    static let fairy    = UIColor(hex: "FFB1FF")
    
    static func typeColor(type: PokemonType) -> UIColor {
        switch type {
        case .normal:
            return ThemeColor.normal
        case .fighting:
            return ThemeColor.fighting
        case .flying:
            return ThemeColor.flying
        case .poison:
            return ThemeColor.poison
        case .ground:
            return ThemeColor.ground
        case .rock:
            return ThemeColor.rock
        case .bug:
            return ThemeColor.bug
        case .ghost:
            return ThemeColor.ghost
        case .steel:
            return ThemeColor.steel
        case .fire:
            return ThemeColor.fire
        case .water:
            return ThemeColor.water
        case .grass:
            return ThemeColor.grass
        case .psychic:
            return ThemeColor.psychic
        case .ice:
            return ThemeColor.ice
        case .dragon:
            return ThemeColor.dragon
        case .dark:
            return ThemeColor.dark
        case .fairy:
            return ThemeColor.fairy
        }
    }
    
    static func typeColorSwiftUI(type: PokemonType) -> Color {
        switch type {
        case .normal:   return Color(hex: "D8D9DA").opacity(0.6)
        case .fighting: return Color(hex: "F28705").opacity(0.6)
        case .flying:   return Color(hex: "95C8FF").opacity(0.6)
        case .poison:   return Color(hex: "9652D9").opacity(0.6)
        case .ground:   return Color(hex: "AA7939").opacity(0.6)
        case .rock:     return Color(hex: "BCB889").opacity(0.6)
        case .bug:      return Color(hex: "9FA423").opacity(0.6)
        case .ghost:    return Color(hex: "6E4570").opacity(0.6)
        case .steel:    return Color(hex: "6AAED3").opacity(0.6)
        case .fire:     return Color(hex: "FF612B").opacity(0.6)
        case .water:    return Color(hex: "2892FF").opacity(0.6)
        case .grass:    return Color(hex: "47BF26").opacity(0.6)
        case .psychic:  return Color(hex: "FF637F").opacity(0.6)
        case .ice:      return Color(hex: "62DFFF").opacity(0.6)
        case .dragon:   return Color(hex: "5462D6").opacity(0.6)
        case .dark:     return Color(hex: "4F4747").opacity(0.6)
        case .fairy:    return Color(hex: "FFB1FF").opacity(0.6)
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
