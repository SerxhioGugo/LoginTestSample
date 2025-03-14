//
//  SuccessView.swift
//  LoginTestSample
//
//  Created by Serxhio Gugo on 3/12/25.
//
import SwiftUI

struct SuccessView: View {
    let email: String
    let onShowLogin: () -> Void 
    
    var body: some View {
        VStack {
            Text("Hello \(email)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("Login Successful!")
                .font(.title2)
                .foregroundColor(.green)
                .accessibilityIdentifier("successMessage")
            
            Button(action: {
                onShowLogin()
            }) {
                Text("Show Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
}
