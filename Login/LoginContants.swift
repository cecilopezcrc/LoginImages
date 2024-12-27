//
//  LoginContants.swift
//  LoginImages
//
//  Created by Ariadna Cecilia López Colín on 26/12/24.
//
import Foundation

struct LoginContants {
    struct sizes {
        static let emailTextFieldTop: CGFloat = 20.0
        static let emailTextFieldWidth: CGFloat = 300.0
        static let emailTextFieldHeight: CGFloat = 40.0
        static let passwordTextFieldTop: CGFloat = 20.0
        static let passwordTextFieldWidth: CGFloat = 300.0
        static let passwordTextFieldHeight: CGFloat = 40.0
        static let loginButtonTop: CGFloat = 20.0
    }
    
    struct strings {
        static let emailTextFieldPlaceholder: String = "Email"
        static let passwordTextFieldPlaceholder: String = "Password"
        static let loginButtonTitle: String = "Login"
        static let alertTitle: String = "Error"
        static let alertTitleMessage: String = "No se puede iniciar sesión"
        static let alertAction: String = "OK"
    }
}
