//
//  LoginView.swift
//  SwiftAuth
//
//  Created by Ashraf Hatia on 10/03/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                //image
                Image("logo-fb")
                    .resizable()
                    .scaledToFill()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 120)
                    .padding(.vertical, 32)
                //form
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email Address",
                              placeHolder: "name@example.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeHolder: "Enter your Password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top,12)
                
                //sign in button
                ButtonView(label: "Sign in", icon: "arrow.right",formValid: formValid) {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                }
                
                Spacer()
                
                //Registration From link
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 4){
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
