//
//  SwitchDeviceView.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 25.04.2022.
//

import SwiftUI

struct SwitchDeviceView: View {
    
    init(device: SmartHomeDevice, devicesModel: DevicesModel) {
        self.device = device
        self.devicesModel = devicesModel
    }
    
    let device: SmartHomeDevice
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var enabled: Bool =  false
    @ObservedObject var devicesModel: DevicesModel
    
    var body: some View {
        Button(
            action: {
                
            },
            label: {
                HStack {
                    Text(device.name)
                    Spacer()
                    Toggle("", isOn: $enabled)
                        .onChange(of: enabled) { value in
                            setSwitchDeviceValue(isEnabled: value)
                        }
                }
            }
        )
        .onAppear{
            enabled = device.value > 0.0
        }
    }
    
    private func setSwitchDeviceValue(isEnabled: Bool) {
        Api().setSwitchDeviceValue(deviceId: device.id, isEnabled: isEnabled)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            Api().getDiveces(devicesModel: devicesModel)
        })
    }
}
