//
//  Tea.swift
//  ANReactiveTableKitExample
//
//  Created by Arjun Nayini on 10/27/19.
//  Copyright © 2019 Arjun Nayini. All rights reserved.
//

import Foundation
import UIKit

struct TeaGroup {
    let name: String
    var teas: [Tea]
    
    static let chineseTeas = TeaGroup(name: "Chinese Teas", teas: TeaRegion.chinese.styles.map { Tea(region: .chinese, style: $0)})
    static let japaneseTeas = TeaGroup(name: "Japanese Teas", teas: TeaRegion.japanese.styles.map { Tea(region: .japanese, style: $0)})
}

struct Tea {
    let region: TeaRegion
    let style: TeaStyle
    let uuid = UUID()

    static func randomTea() -> Tea {
        let randomRegion = TeaRegion.allCases.randomElement()!
        let randomStyleForRegion = randomRegion.styles.randomElement()!
        return Tea(region: randomRegion, style: randomStyleForRegion)
    }
    
    var name: String {
        return self.style.rawValue
    }
}

enum TeaStyle: String {
    case sencha = "Sencha"
    case gyokuro = "Bancha"
    case matcha = "Matcha"
    case daHongPao = "Da Hong Pao"
    case dragonwell = "Dragonwell"
    case tieguanyin = "Tieguanyin"
}

enum TeaRegion: CaseIterable {
    case chinese
    case japanese

    var name: String {
        switch self {
        case .chinese:
            return "Chinese"
        case .japanese:
            return "Japanese"
        }
    }
    
    var styles: [TeaStyle] {
        switch self {
        case .chinese:
            return [.daHongPao, .dragonwell, .tieguanyin]
        case .japanese:
            return [.sencha, .matcha, .gyokuro]
        }
    }

    var emoji: String {
        switch self {
        case .chinese:
            return "🇨🇳"
        case .japanese:
            return "🇯🇵"
        }
    }
}
