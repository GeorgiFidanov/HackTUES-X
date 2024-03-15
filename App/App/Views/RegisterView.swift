//
//  RegisterView.swift
//  App
//
//  Created by Andrea Petrenko on 14.03.24.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var isRegisterIn = false
    
    var body: some View {
        ZStack {
            Color.white // Background color
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140, height: 140)
                    .foregroundColor(.blue)
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                Button(action: {
                    //registerUser()
                    print("g")
                }) {
                    Text("Register")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.blue)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(8)
                .padding(.horizontal)
                
            }
            .navigationDestination(isPresented: $isRegisterIn) {
                MainView(temperature: 25.0, salinity: 35.0, noise: 45.0, murkiness: 55.0, name: "Station1", location: "cherno more")
                }
                .navigationBarBackButtonHidden(true)
            
            .padding(.top, -100)
        }
    }
    
    func registerUser() {
        guard let url = URL(string: "http://172.20.10.3:8000/api/register") else {
            print("Invalid URL")
            return
        }
        
        let parameters = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error serializing parameters: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                if let data = data {
                    if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
                        isRegisterIn = true
                        print("Response:", responseJSON)
                    }
                }
            } else {
                print("HTTP Error:", httpResponse.statusCode)
            }
        }.resume()
    }
}

#Preview {
    RegisterView()
}
