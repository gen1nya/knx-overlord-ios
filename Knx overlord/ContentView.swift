//
//  ContentView.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 09.04.2022.
//

import SwiftUI
import CoreData

class DevicesModel: ObservableObject {
    @Published var deviceList: [SmartHomeDevice]
    
    init() {
        deviceList = [SmartHomeDevice]()
    }
}

struct SmartHomeDevice: Codable, Identifiable, Hashable {
    let id: Int
    let type: String
    let name: String
    let page: String
    let kind: String
    let value: Double
}


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var devicesModel: DevicesModel
    
    @State private var editMode = EditMode.inactive

    var body: some View {
        
        TabView {
            NavigationView {
                List {
                    ForEach(devicesModel.deviceList.filter({ device in
                        device.page == "LOUNGE"
                    }), id: \.self) { i in
                        switch i.type {
                        case "SWITCH":
                            SwitchDeviceView(device: i, devicesModel: devicesModel)
                        case "ANALOG_WITHOUT_DIMMING":
                            SwitchDeviceView(device: i, devicesModel: devicesModel)
                        case "ANALOG":
                            AnalogDeviceView(device: i, devicesModel: devicesModel)
                        default: Color.clear
                        }
                    }
                    .onMove(perform: onMove)
                }
                .navigationBarTitle("Lounge")
                .navigationBarItems(leading: EditButton())
                .environment(\.editMode, $editMode)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Lounge")
            }
            .tag(0)
            NavigationView {
                List {
                    ForEach(devicesModel.deviceList.filter({ device in
                        device.page == "MASTER_BEDROOM"
                    }), id: \.self) { i in
                        switch i.type {
                        case "SWITCH":
                            SwitchDeviceView(device: i, devicesModel: devicesModel)
                        case "ANALOG_WITHOUT_DIMMING":
                            SwitchDeviceView(device: i, devicesModel: devicesModel)
                        case "ANALOG":
                            AnalogDeviceView(device: i, devicesModel: devicesModel)
                        default: Color.clear
                        }
                    }
                    .onMove(perform: onMove)
                }
                .navigationBarTitle("Master bedroom")
                .navigationBarItems(leading: EditButton())
                .environment(\.editMode, $editMode)
            }
             .tabItem {
                 Image(systemName: "house")
                 Text("Master bedroom")
              }
             .tag(1)
        }
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        devicesModel.deviceList.move(fromOffsets: source, toOffset: destination)
    }
    
    private func toggleDevice(device: SmartHomeDevice) {
        Api().toggleDevice(device: device)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            Api().getDiveces(devicesModel: devicesModel)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            
        }
    }
}
