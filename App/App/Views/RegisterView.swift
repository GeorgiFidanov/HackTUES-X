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
    @State private var confirmPassword = ""
    @State private var isRegisterIn = false
    @State private var errorMessage: RegistrationError?
    @State private var deviceDataArray: [DeviceData] = []
    
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
                
                SecureField("Confirm password", text: $confirmPassword)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                if let errorMessage = errorMessage {
                    if errorMessage == RegistrationError.passwordsDoNotMatch {
                        Text("Passwords didn't match!")
                            .foregroundColor(.red)
                    } else if errorMessage == RegistrationError.Error {
                        Text("Error")
                            .foregroundColor(.red)
                    }
                }
                
                Button(action: {
                    //print("g")
                    //isRegisterIn = true
                    registerUser { error in
                        if let error = error {
                            print("Error:", error.localizedDescription)
                        } else {
                            print("Registration successful")
                            isRegisterIn = true
                        }
                    }
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
                MainView(temperature: 25.0, salinity: 35.0, noise: 45.0, murkiness: 55.0, name: "Station1", location: "cherno more", deviceDataArray: $deviceDataArray)
                }
                .navigationBarBackButtonHidden(true)
            
            .padding(.top, -100)
        }
    }
    
    func registerUser(completion: @escaping (Error?) -> Void) {
        if confirmPassword != password {
            let error = NSError(domain: "PasswordMismatchError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Passwords do not match"])
            errorMessage = RegistrationError.passwordsDoNotMatch
            completion(error)
            return
        }
        
        guard let url = URL(string: "http://192.168.166.172:8000/api/register") else {
            print("Invalid URL")
            completion(nil)
            errorMessage = RegistrationError.Error
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
            completion(error)
            errorMessage = RegistrationError.Error
            return
        }
        
        /*URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }*/
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                errorMessage = RegistrationError.Error
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                errorMessage = RegistrationError.Error
                completion(nil)
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                /*if let data = data {
                    if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
                        isRegisterIn = true
                        print("Response:", responseJSON)
                        completion(nil)
                    }
                }*/
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
                    isRegisterIn = true
                    let responseData = responseJSON as? [String : Any]
                    
                    guard let token = responseData?["token"] as? String else {
                        print("Token not found in response data")
                        return
                    }
                    
                    //print(responseData)
                    
                    getDeviceData(token: token)
                } else {
                    print("Invalid JSON response")
                }
            } else {
                print("HTTP Error:", httpResponse.statusCode)
                errorMessage = RegistrationError.Error
                completion(nil)
            }
        }.resume()
    }
    
    func getDeviceData(token: String){
        print("Token:", token)
        guard let url = URL(string: "http://192.168.166.172:8000/api/device/1") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                do {
                    let decoder = JSONDecoder()
                    deviceDataArray = try decoder.decode([DeviceData].self, from: data)
                    //print("Device Data Array:", deviceDataArray[1])
                } catch {
                    print("Error decoding JSON:", error)
                }
            } else {
                print("HTTP Error:", httpResponse.statusCode)
            }
        }.resume()
    }
}

enum RegistrationError: Error{
    case passwordsDoNotMatch
    case invalidURL
    case HTTPError
    case Error
    
}

#Preview {
    RegisterView()
}
