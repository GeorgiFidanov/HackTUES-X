//
//  MainView.swift
//  App
//
//  Created by Andrea Petrenko on 14.03.24.
//

import SwiftUI

struct MainView: View {
    let temperature: Double
    let salinity: Double
    let noise: Double
    let murkiness: Double
    let name: String
    let location: String
    @State private var loading = false
    @Binding var deviceDataArray: [DeviceData]
    
    @State private var showCurrentData = false
    
    var content: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Station\(deviceDataArray.first!.device_id)")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
                
                Text("📍\(deviceDataArray.first!.created_at)")
                    .font(.system(size: 18))
                    .padding(.top, -14)
                    .foregroundColor(.primary)
                
                
                VStack {
                    Toggle(isOn: $showCurrentData) {
                        Text(showCurrentData ? "Hide current data" : "Show current data")
                            .font(.system(size: 18))
                            .padding(.top, -14)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    if showCurrentData {
                        CurrentStationDataView(temperature: deviceDataArray.first!.temperature, salinity: deviceDataArray.first!.salinity, noise: deviceDataArray.first!.noise, murkiness: deviceDataArray.first!.murkiness)
                    } else {
                        Divider().background(Color.black)
                        Text("Temperature's data")
                            .padding(.top)
                        TempGraphicsView(dataCollection: ViewModel(deviceDataArray: deviceDataArray), deviceDataArray: deviceDataArray)
                        Divider().background(Color.black)
                        Text("Salinity's data")
                            .padding(.top)
                        SalinityGraphicsView(dataCollection: ViewModel2(deviceDataArray: deviceDataArray), deviceDataArray: deviceDataArray)
                        Divider().background(Color.black)
                        Text("Noise's data")
                            .padding(.top)
                        NoiseGraphicsView(dataCollection: ViewModel3())
                        Divider().background(Color.black)
                        Text("Murkines's data")
                            .padding(.top)
                        MurkinessGraphicsView(dataCollection: ViewModel4())
                    }
                }
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .padding()
        }
    }
    
    var placeholder: some View{
        VStack {
                Text("Loading...")
                .padding(.top, 300)
                Image(systemName: "arrow.2.circlepath")
                    .rotationEffect(.degrees(loading ? 360 : 0))
                    .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .padding(.top, 20)
                Spacer()
            }
            .onAppear {
                self.loading = true
            }
    }
    
    var body: some View {
        if let value = deviceDataArray.first {
            content
        } else {
            placeholder
        }
    }
}

#Preview {
    MainView(temperature: 10, salinity: 20, noise: 30, murkiness: 40, name: "Station1", location: "Cherno more", deviceDataArray: .constant([]))
}
