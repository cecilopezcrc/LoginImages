//
//  LoginModel.swift
//  LoginImages
//
//  Created by Ariadna Cecilia López Colín on 26/12/24.
//

struct User: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
}

