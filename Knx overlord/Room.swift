//
//  Room.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 25.04.2022.
//

import Foundation


struct SmartHomeDevice: Codable, Identifiable, Hashable {
    let id: Int
    let type: String
    let name: String
    let page: String
    let kind: String
    let value: Double
}

struct Room: Codable, Hashable {
    let name: String
    var devices: [SmartHomeDevice]
}
