//
//  LoginViewModel.swift
//  LoginImages
//
//  Created by Ariadna Cecilia López Colín on 26/12/24.
//

import Foundation

class LoginViewModel {

    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        if email.isEmpty || password.isEmpty {
            completion(false)
            return
        }
        let loginURL = URL(string: "https://reqres.in/api/login")!
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error)")
                completion(false)
                return
            }
            
            guard let data = data else {
                print("Error: No response received from API")
                completion(false)
                return
            }
            
            do {
                let jsonResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                if let token = jsonResponse.token {
                    UserDefaults.standard.setValue(token, forKey: "userToken")
                    print("Token saved: \(token)")
                    completion(true)
                } else {
                    print("No token was received in the response.")
                    completion(false)
                }
            } catch {
                print("Error parsing response: \(error)")
                completion(false)
            }
        }
        task.resume()
    }
}
