//
//  LoginView.swift
//  LoginTestSample
//
//  Created by Serxhio Gugo on 3/12/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.system(.title2))
                    TextField("Enter email", text: $viewModel.emailText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .accessibilityIdentifier("username")
                    
                    Text("Password")
                        .font(.system(.title2))
                    SecureField("Password", text: $viewModel.passwordText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .accessibilityIdentifier("password")
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.isLoading ? Color.gray : Color.blue)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top)
                    }
                    .disabled(viewModel.isLoading)
                    .accessibilityIdentifier("loginButton")
                }
                .padding()
                
                Spacer()
            }
        }
    }
}
