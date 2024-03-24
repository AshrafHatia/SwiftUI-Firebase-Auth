//
//  ProfileView.swift
//  SwiftAuth
//
//  Created by Ashraf Hatia on 15/03/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var confirmationFromUser = false
    
    var body: some View {
        if let user = viewModel.currentUser {
            List{
                Section{
                    HStack {
                        Text(user.initials)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72,height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading,spacing: 4){
                            Text(user.firstName + " " + user.lastName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }
                
                Section("General"){
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                
                Section("Account"){
                    Button(role: .destructive, action: {
                        confirmationFromUser = true
                    }, label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out", tintColor: Color(.red))
                    })
                    .confirmationDialog("Sign Out", isPresented: $confirmationFromUser) {
                        Button("Yes") {
                            withAnimation {
                                viewModel.signOut()
                            }
                        }
                        Button("No",role: .cancel) {}
                    } message: {
                        Text("Are You sure you want to sign out?")
                    }
                    
                    Button(role: .destructive, action: {
                        confirmationFromUser = true
                    }, label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Delete Account", tintColor: Color(.red))
                    })
                    .confirmationDialog("Are you sure?", isPresented: $confirmationFromUser) {
                        Button("Yes") {
                            withAnimation {
                                viewModel.deleteAccount()
                            }
                        }
                    } message: {
                        Text("Are You sure you want to delete account?")
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
