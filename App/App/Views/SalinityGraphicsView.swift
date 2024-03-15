//
//  SalinityGraphicsView.swift
//  App
//
//  Created by Andrea Petrenko on 15.03.24.
//

import SwiftUI
import Charts
import Observation

struct SalinityGraphicsView: View {
    var dataCollection: ViewModel2
        
    var body: some View {
        VStack {
            Chart(dataCollection.data) {
                LineMark(
                    x: .value("Hour", $0.hour),
                    y: .value("Total", $0.salinity)
                )
            }
            .padding()
            .frame(height: 200)
            
            Text("Min: \(String(format: "%.1f", dataCollection.minSalinity)) , Max: \(String(format: "%.1f", dataCollection.maxSalinity)) , Avrg: \(String(format: "%.1f", dataCollection.averageSalinity))")
        }
    }
}

struct AverageSalinity: Identifiable {
    var id = UUID()
    var hour: String
    var salinity: Double
}

@Observable
class ViewModel2 {
    var data: [AverageSalinity] = [
        AverageSalinity(hour: "11", salinity: 9),
        AverageSalinity(hour: "12", salinity: 10),
        AverageSalinity(hour: "13", salinity: 14),
        AverageSalinity(hour: "14", salinity: 7),
        AverageSalinity(hour: "15", salinity: 18),
        AverageSalinity(hour: "16", salinity: 10),
    ]
    
    var minSalinity: Double {
        data.map(\.salinity).min() ?? 0
    }
    
    var maxSalinity: Double {
        data.map(\.salinity).max() ?? 0
    }
    
    var averageSalinity: Double {
        data.map(\.salinity).reduce(0, +) / Double(data.count)
    }
}


struct SalinityGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        SalinityGraphicsView(dataCollection: ViewModel2())
    }
}

