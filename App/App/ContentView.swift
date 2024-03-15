//
//  ContentView.swift
//  App
//
//  Created by Andrea Petrenko on 14.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var isRegisterIn = false
    @State private var responseData: [String: Any]?
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.white // Background color
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image("icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .foregroundColor(.blue)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.3))
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
                        //loginUser()
                        print("f")
                        isLoggedIn = true
                    }) {
                        Text("Login")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    Button(action: {
                     isRegisterIn = true
                    }) {
                        HStack{
                            Spacer()
                            Text("Create an account")
                                .font(.system(size: 18))
                                .padding(.trailing, 20)
                        }
                    }
                }
                
                .navigationDestination(isPresented: $isLoggedIn) {
                    MainView(temperature: 32, salinity: 40, noise: 50, murkiness: 60, name: "Station1", location: "Cherno more")
                        .navigationBarBackButtonHidden(true)
                }
                
                .navigationDestination(isPresented: $isRegisterIn) {
                    RegisterView()
                }
                
                .padding()
            }
            .padding(.top, -100)
        }.tint(.black)
    }
    
    func loginUser() {
        guard let url = URL(string: "http://172.20.10.3:8000/api/login") else {
            print("Invalid URL")
            return
        }
        
        let parameters = ["email": email, "password": password]
        
        guard let postData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Failed to encode parameters")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
        
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
                if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
                    isLoggedIn = true
                    responseData = responseJSON as? [String : Any]
                    print(responseData)
                    //print("Response:", responseJSON)
                } else {
                    print("Invalid JSON response")
                }
            } else {
                print("HTTP Error:", httpResponse.statusCode)
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
