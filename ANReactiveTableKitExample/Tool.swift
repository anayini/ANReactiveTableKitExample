//
//  Tool.swift
//  ANReactiveTableKitExample
//
//  Created by Arjun Nayini on 9/27/19.
//  Copyright © 2019 Arjun Nayini. All rights reserved.
//

import Foundation

struct ToolGroup {
    let name: String
    var tools: [Tool]
}

struct Tool {
    let type: ToolType
    let uuid = UUID()

    static func randomTool() -> Tool {
        let randomNumber = UInt32.random(in: 0..<UInt32(ToolType.allValues.count))
        return Tool(type: ToolType(rawValue: randomNumber)!)
    }
}

enum ToolType: UInt32 {
    case hammer
    case wrench
    case clamp
    case nutBolt
    case crane

    static let allValues: [ToolType] = [.hammer, .wrench, .clamp, .nutBolt, .crane]

    var name: String {
        switch self {
        case .hammer:
            return "Hammer"
        case .wrench:
            return "Wrench"
        case .clamp:
            return "Clamp"
        case .nutBolt:
            return "Bolt"
        case .crane:
            return "Crane"
        }
    }

    var emoji: String {
        switch self {
        case .hammer:
            return "🔨"
        case .wrench:
            return "🔧"
        case .clamp:
            return "🗜️"
        case .nutBolt:
            return "🔩"
        case .crane:
            return "🏗️"
        }
    }
}
