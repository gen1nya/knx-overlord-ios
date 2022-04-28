//
//  SwitchDeviceView.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 25.04.2022.
//

import SwiftUI

struct AnalogDeviceView: View {
    
    init(device: SmartHomeDevice, devicesModel: DevicesModel) {
        self.device = device
        self.devicesModel = devicesModel
    }
    
    let device: SmartHomeDevice
    
    @State var value: Double = 0.0
    @ObservedObject var devicesModel: DevicesModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Button(
            action: {
                
            },
            label: {
                VStack {
                    HStack {
                        Text(device.name)
                        Spacer()
                    }
                    Slider(value: $value, in: 0...100) { editing in
                        print(editing)
                        if !editing {
                            device.value = value
                            setAnalogDeviceValue(value: value)
                        }
                    }
                    //Text(String(device.value > 0.0))
                }
            }
        )
        .onAppear{
            value = device.value
        }
    }
    
    private func setAnalogDeviceValue(value: Double) {
        print(value)
        Api().setAnalogDeviceValue(deviceId: device.id, value: value)
    }
}
