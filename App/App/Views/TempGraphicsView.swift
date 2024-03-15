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
        
    var body: some View {
        // 1.
        Chart(dataCollection.data) {
            // 2.
            LineMark(
                // 3.
                x: .value("Hour", $0.hour),
                y: .value("Total", $0.temperature)
            )
        }
        .padding()
        .frame(height: 200)
    }
}

struct AverageTemperature: Identifiable {
    var id = UUID()
    var hour: String
    var temperature: Double
}

@Observable
class ViewModel {
        // 3.
    var data: [AverageTemperature] = [
        AverageTemperature(hour: "10", temperature: 10),
        AverageTemperature(hour: "11", temperature: 9),
        AverageTemperature(hour: "12", temperature: 14),
        AverageTemperature(hour: "13", temperature: 10),
        AverageTemperature(hour: "14", temperature: 18),
        AverageTemperature(hour: "15", temperature: 14),
        
    ]
}

struct TempGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        TempGraphicsView(dataCollection: ViewModel())
    }
}

