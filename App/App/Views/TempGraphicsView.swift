//
//  TempGraphicsView.swift
//  App
//
//  Created by Andrea Petrenko on 15.03.24.
//

import SwiftUI
import Observation
import Charts

struct TempGraphicsView: View {
    var dataCollection: ViewModel
    var deviceDataArray: [DeviceData]
        
    var body: some View {
        let lastTenData = Array(deviceDataArray.suffix(10))
        let dataCollection = ViewModel(deviceDataArray: deviceDataArray)
        
        VStack {
            Chart(dataCollection.data) {
                LineMark(
                    x: .value("Hour", $0.hour),
                    y: .value("Total", $0.temperature)
                )
            }
            .padding()
            .frame(height: 200)
            .chartYScale(domain: 22...25)
            
            Text("Time")
            Text("Min: \(String(format: "%.1f", dataCollection.minTemperature)) , Max: \(String(format: "%.1f", dataCollection.maxTemperature)) , Avrg: \(String(format: "%.1f", dataCollection.averageTemperature))")
        }
    }
}

struct AverageTemperature: Identifiable {
    var id = UUID()
    var hour: String
    var temperature: Double
}

@Observable
class ViewModel {
    var data: [AverageTemperature]
        
    init(deviceDataArray: [DeviceData]) {
        data = deviceDataArray.prefix(100).map { deviceData in
            AverageTemperature(hour: deviceData.created_at, temperature: deviceData.temperature)
        }
        //print(deviceDataArray.prefix(6))
    }
    /*var data: [AverageTemperature] = [
        AverageTemperature(hour: "10", temperature: 10),
        AverageTemperature(hour: "11", temperature: 9),
        AverageTemperature(hour: "12", temperature: 14),
        AverageTemperature(hour: "13", temperature: 10),
        AverageTemperature(hour: "14", temperature: 18),
        AverageTemperature(hour: "15", temperature: 14),
        
    ]*/
    
    var minTemperature: Double {
        data.map(\.temperature).min() ?? 0
    }
    
    var maxTemperature: Double {
        data.map(\.temperature).max() ?? 0
    }
    
    var averageTemperature: Double {
        data.map(\.temperature).reduce(0, +) / Double(data.count)
    }
}

struct TempGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        TempGraphicsView(dataCollection: ViewModel(deviceDataArray: []), deviceDataArray: [])
    }
}

