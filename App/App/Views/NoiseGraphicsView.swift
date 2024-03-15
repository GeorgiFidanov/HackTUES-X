//
//  NoiseGraphicsView.swift
//  App
//
//  Created by Andrea Petrenko on 15.03.24.
//

import SwiftUI
import Charts
import Observation

struct NoiseGraphicsView: View {
    var dataCollection: ViewModel3
    
        
    var body: some View {
        VStack {
            Chart(dataCollection.data) {
                LineMark(
                    x: .value("Hour", $0.hour),
                    y: .value("Total", $0.noise)
                )
            }
            .padding()
            .frame(height: 200)
            
            Text("Min: \(String(format: "%.1f", dataCollection.minNoise)) , Max: \(String(format: "%.1f", dataCollection.maxNoise)) , Avrg: \(String(format: "%.1f", dataCollection.averageNoise))")
        }
    }
}

struct AverageNoise: Identifiable {
    var id = UUID()
    var hour: String
    var noise: Double
}

@Observable
class ViewModel3 {
    var data: [AverageNoise] = [
        AverageNoise(hour: "10", noise: 7),
        AverageNoise(hour: "11", noise: 11),
        AverageNoise(hour: "12", noise: 14),
        AverageNoise(hour: "13", noise: 5),
        AverageNoise(hour: "14", noise: 18),
        AverageNoise(hour: "15", noise: 14),
    ]
    
    var minNoise: Double {
        data.map(\.noise).min() ?? 0
    }
    
    var maxNoise: Double {
        data.map(\.noise).max() ?? 0
    }
    
    var averageNoise: Double {
        data.map(\.noise).reduce(0, +) / Double(data.count)
    }
}

struct NoiseGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        NoiseGraphicsView(dataCollection: ViewModel3())
    }
}
