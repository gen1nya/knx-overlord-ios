//
//  Knx_overlordApp.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 09.04.2022.
//

import SwiftUI

@main
struct Knx_overlordApp: App {
    let persistenceController = PersistenceController.shared

    @StateObject var devicesModel: DevicesModel = DevicesModel()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView(devicesModel: devicesModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: {
                    Api().getDiveces(devicesModel: devicesModel)
                })
        }
    }
}
