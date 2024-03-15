//
//  ChooseDeviceView.swift
//  App
//
//  Created by Andrea Petrenko on 15.03.24.
//

import SwiftUI
struct Device: Identifiable {
    let id = UUID()
    let name: String
    let location: String
}

struct ChooseDeviceView: View {
    let devices: [Device] = [
        Device(name: "1", location : "Sofia"),
        
    ]
    
    @State private var selectedDevice: Device?

    var body: some View {
        NavigationView {
            List(devices) { device in
                Button(action: {
                    self.selectedDevice = device
                }) {
                    Text("\(device.name), \(device.location)")
                }
            }
            .navigationTitle("Choose Device")
        }
        .sheet(item: $selectedDevice) { device in
            DeviceView(device: device)
        }
    }
}

struct DeviceView: View {
    let device: Device
    
    var body: some View {
        Text("Device: \(device.name)")
            .navigationTitle(device.name)
    }
}

struct ChooseDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDeviceView()
    }
}
