//
//  Api.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 24.04.2022.
//

import Foundation

class Api {
    
    func getDiveces(devicesModel: DevicesModel) {
        let url = URL(string: "http://192.168.1.161:8000/server/devices/")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let result = try? JSONDecoder().decode([SmartHomeDevice].self, from: data) ?? []
            DispatchQueue.main.async() {
                devicesModel.deviceList = result!
                print(result)
            }
        }

        task.resume()
    }
    
    func toggleDevice(device: SmartHomeDevice) {
        let url = URL(string: "http://192.168.1.161:8000/device/toggle?id=\(device.id)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    func setAnalogDeviceValue(deviceId: Int, value: Double) {
        let url = URL(string: "http://192.168.1.161:8000/device/analog?id=\(deviceId)&value=\(value)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    func setSwitchDeviceValue(deviceId: Int, isEnabled: Bool) {
        let url = URL(string: "http://192.168.1.161:8000/device/switch?id=\(deviceId)&enable=\(isEnabled)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
