//
//  MurkinessGraphicsView.swift
//  App
//
//  Created by Andrea Petrenko on 15.03.24.
//

import SwiftUI
import Charts
import Observation

struct MurkinessGraphicsView: View {
    var dataCollection: ViewModel4
    var deviceDataArray: [DeviceData]
        
    var body: some View {
        let lastTenData = Array(deviceDataArray.suffix(10))
        let dataCollection = ViewModel4(deviceDataArray: deviceDataArray)
        
        VStack {
            Chart(dataCollection.data) {
                LineMark(
                    x: .value("Hour", $0.hour),
                    y: .value("Total", $0.murkiness)
                )
            }
            .padding()
            .frame(height: 200)
            .chartYScale(domain: 1...3)
            
            Text("Min: \(String(format: "%.1f", dataCollection.minMurkiness)) , Max: \(String(format: "%.1f", dataCollection.maxMurkiness)) , Avrg: \(String(format: "%.1f", dataCollection.averageMurkiness))")
        }
    }
}

struct AverageMurkiness: Identifiable {
    var id = UUID()
    var hour: String
    var murkiness: Double
}

@Observable
class ViewModel4 {
    var data: [AverageMurkiness]
    /*var data: [AverageMurkiness] = [
        AverageMurkiness(hour: "10", murkiness: 5),
        AverageMurkiness(hour: "11", murkiness: 8),
        AverageMurkiness(hour: "12", murkiness: 6),
        AverageMurkiness(hour: "13", murkiness: 8),
        AverageMurkiness(hour: "14", murkiness: 5),
        AverageMurkiness(hour: "15", murkiness: 5),
    ]*/
    
    init(deviceDataArray: [DeviceData]) {
        data = deviceDataArray.prefix(100).map { deviceData in
            AverageMurkiness(hour: deviceData.created_at, murkiness: deviceData.murkiness)
        }
        //print(deviceDataArray.prefix(6))
    }
    
    var minMurkiness: Double {
        data.map(\.murkiness).min() ?? 0
    }
    
    var maxMurkiness: Double {
        data.map(\.murkiness).max() ?? 0
    }
    
    var averageMurkiness: Double {
        data.map(\.murkiness).reduce(0, +) / Double(data.count)
    }
}

struct MurkinessGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        MurkinessGraphicsView(dataCollection: ViewModel4(deviceDataArray: []), deviceDataArray: [])
    }
}
