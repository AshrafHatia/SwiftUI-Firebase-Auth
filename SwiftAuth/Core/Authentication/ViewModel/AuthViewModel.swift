//
//  AuthViewModel.swift
//  SwiftAuth
//
//  Created by Ashraf Hatia on 16/03/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG : Failed to login user \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, firstname: String, lastname: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            
            let user = User(id: result.user.uid, firstName: firstname, lastName: lastname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("user").document(user.id).setData(encodedUser)
            
            await fetchUser()
        } catch{
            print("DEBUG : Failed to create user \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // sign out user from firebase backend
            self.userSession = nil // removed user session
            self.currentUser = nil // clear current user data model
        } catch {
            print("DEBUG : Failed to sign out \(error.localizedDescription)")
        }
    }
    
    
    func deleteAccount() {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            Firestore.firestore().collection("user").document(uid).delete()
            try Auth.auth().signOut()
            self.userSession = nil // removed user session
            self.currentUser = nil // clear current user data model
        } catch {
            print("DEBUG : Failed to delete user \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        do{
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            guard let snapshot = try? await Firestore.firestore().collection("user").document(uid).getDocument() else { return }
            self.currentUser = try snapshot.data(as: User.self)
            
            print("DEBUG : Current user is \(String(describing: self.currentUser) )")
            
        } catch {
            print("DEBUG : Failed to fecth user \(error.localizedDescription)")
        }
    }
}
