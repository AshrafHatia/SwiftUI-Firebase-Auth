//
//  RegistrationView.swift
//  SwiftAuth
//
//  Created by Ashraf Hatia on 14/03/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
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
                
                InputView(text: $firstname, title: "First Name",
                          placeHolder: "Enter your first name")
                
                InputView(text: $lastname, title: "Last Name",
                          placeHolder: "Enter your last name")
                
                InputView(text: $password,
                          title: "Password",
                          placeHolder: "Enter your Password",
                          isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeHolder: "Confirm your Password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "checkmark.circle.badge.xmark.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top,12)
            
            ButtonView(label: "Sign Up", icon: "arrow.right",formValid: formValid) {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password,
                                                   firstname:firstname, lastname:lastname)
                }
            }
            
            Spacer()
            
            Button(action: {
                dismiss()
            }, label: {
                HStack(spacing: 4){
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.system(size: 14))
            })
        }
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !firstname.isEmpty
        && !lastname.isEmpty
        
    }
}

#Preview {
    RegistrationView()
}
