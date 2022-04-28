//
//  ContentView.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 09.04.2022.
//

import SwiftUI
import CoreData

class DevicesModel: ObservableObject {
    @Published var rooms: [Room]
    
    init() {
        rooms = [Room]()
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var devicesModel: DevicesModel
    
    var body: some View {
        
        TabView {
            ForEach(devicesModel.rooms, id: \.self) { room in
                NavigationView {
                    RoomView(rooms: devicesModel, room: room)
                }
                .tabItem {
                    Image(systemName: "house")
                    Text(room.name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{}
    }
}
