//
//  CurrentStationDataView.swift
//  App
//
//  Created by Andrea Petrenko on 15.03.24.
//

import SwiftUI

import SwiftUI

struct CurrentStationDataView: View {
    let temperature: Double
    let salinity: Double
    let noise: Double
    let murkiness: Double
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image("temp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                DataItemView(title: "Temperature ", value: "\(temperature) °C")
                    .font(.system(size: 30))
            }
            
            HStack {
                Image("salinity")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                DataItemView(title: "Salinity", value: "\(salinity) ppm")
                    .font(.system(size: 30))
            }
            
            HStack {
                Image("noise")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                DataItemView(title: "Noise", value: "\(noise) dB")
                    .font(.system(size: 30))
            }
            
            HStack {
                Image("murkiness")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                DataItemView(title: "Murkiness", value: "\(murkiness) NTU")
                    .font(.system(size: 30))
            }
        }
    }
}

struct DataItemView: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
        .padding(.horizontal)
    }
}




#Preview {
    CurrentStationDataView(temperature: 10, salinity: 20, noise: 30, murkiness: 40)
}
