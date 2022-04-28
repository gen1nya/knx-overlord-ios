//
//  Api.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 24.04.2022.
//

import Foundation

class Api {
    
    private let host = "http://192.168.1.161:8000"
    private let flat = "101"
    
    func getDiveces(devicesModel: DevicesModel) {
        let url = URL(string: "\(host)/v2/server/devices/")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let result = try? JSONDecoder().decode([Room].self, from: data)
            DispatchQueue.main.async() {
                devicesModel.rooms = result!
                print(result!)
            }
        }

        task.resume()
    }
    
    func toggleDevice(device: SmartHomeDevice) {
        let url = URL(string: "\(host)/device/toggle?id=\(device.id)&flat=\(flat)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    func setAnalogDeviceValue(deviceId: Int, value: Double) {
        let url = URL(string: "\(host)/device/analog?id=\(deviceId)&value=\(value)&flat=\(flat)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    func setSwitchDeviceValue(deviceId: Int, isEnabled: Bool) {
        let url = URL(string: "\(host)/device/switch?id=\(deviceId)&enable=\(isEnabled)&flat=\(flat)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
