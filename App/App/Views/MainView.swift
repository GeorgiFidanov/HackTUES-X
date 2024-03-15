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
    
    @State private var showCurrentData = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(name)")
                .font(.title)
                .bold()
                .padding(.top, 20)
            
            Text("📍\(location)")
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
                    CurrentStationDataView(temperature: temperature, salinity: salinity, noise: noise, murkiness: murkiness)
                } else {
                    TempGraphicsView(dataCollection: ViewModel())
                    
                }
            }
                
                       
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MainView(temperature: 10, salinity: 20, noise: 30, murkiness: 40, name: "Station1", location: "cherno more")
}
