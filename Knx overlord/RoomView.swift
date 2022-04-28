//
//  RoomView.swift
//  Knx overlord
//
//  Created by Евгений Андриянов on 25.04.2022.
//

import SwiftUI

struct RoomView: View {

    @State private var room: Room

    init(rooms: DevicesModel, room: Room) {
        self.rooms = rooms
        _room = State(initialValue: room)
    }

    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject private var rooms: DevicesModel

    @State private var editMode = EditMode.inactive

    var body: some View {
        List {
            ForEach(room.devices, id: \.self) { i in
                switch i.type {
                case "SWITCH":
                    SwitchDeviceView(device: i, devicesModel: rooms)
                case "ANALOG_WITHOUT_DIMMING":
                    SwitchDeviceView(device: i, devicesModel: rooms)
                case "ANALOG":
                    AnalogDeviceView(device: i, devicesModel: rooms)
                default: Color.clear
                }
            }
                    .onMove(perform: onMove)
                    .deleteDisabled(true)
                    .swipeActions {
                        Button("Add"){}.tint(.green)
                    }
        }
                .navigationBarTitle(room.name)
                .navigationBarItems(leading: EditButton())
                .environment(\.editMode, $editMode)
    }

    private func onMove(source: IndexSet, destination: Int) {
        room.devices.move(fromOffsets: source, toOffset: destination)
    }
}

final class MyCustomViewModel: NSObject, ObservableObject, UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Kick Out!"
    }
}