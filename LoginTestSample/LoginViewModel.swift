//
//  LoginViewModel.swift
//  LoginTestSample
//
//  Created by Serxhio Gugo on 3/12/25.
//
import Foundation

class LoginViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func login() {
        if emailText.isEmpty || passwordText.isEmpty {
            errorMessage = "Please fill in all fields"
            return
        }
        
        if !isValidEmail(emailText) {
            errorMessage = "Please enter a valid email address"
            return
        }
        
        if !isValidPassword(passwordText) {
            errorMessage = "Password must be at least 8 characters with 1 uppercase letter and 1 number"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            
            if self.emailText == "test@example.com" && self.passwordText == "Emolala123" {
                self.isLoggedIn = true
            } else {
                self.errorMessage = "Invalid credentials"
            }
        }
    }
    
    // New function to reset login state
    func resetLogin() {
        isLoggedIn = false
        emailText = ""
        passwordText = ""
        errorMessage = nil
        isLoading = false
    }
}
