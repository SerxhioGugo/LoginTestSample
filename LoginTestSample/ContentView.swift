//
//  ContentView.swift
//  LoginTestSample
//
//  Created by Serxhio Gugo on 3/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showLogin = true
    
    var body: some View {
        SuccessView(email: viewModel.emailText) {
            viewModel.resetLogin()
            showLogin = true
        }
        .fullScreenCover(isPresented: $showLogin) {
            LoginView(viewModel: viewModel)
                .onChange(of: viewModel.isLoggedIn) { _, newValue in
                    if newValue {
                        showLogin = false
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
