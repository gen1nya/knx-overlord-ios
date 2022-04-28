//
//  Room.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 25.04.2022.
//

import Foundation


class SmartHomeDevice: Codable, Identifiable, Hashable {
    static func ==(lhs: SmartHomeDevice, rhs: SmartHomeDevice) -> Bool {
        lhs.id == rhs.id && lhs.value == rhs.value
    }

    let id: Int
    let type: String
    let name: String
    let page: String
    let kind: String
    var value: Double

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(value)
        hasher.finalize()
    }
}

class Room: Codable, Hashable {
    static func ==(lhs: Room, rhs: Room) -> Bool {
        lhs.devices == rhs.devices && lhs.name == rhs.name
    }

    let name: String
    var devices: [SmartHomeDevice]

    func hash(into hasher: inout Hasher) {
        hasher.combine(devices)
        hasher.combine(name)
        hasher.finalize()
    }
}
