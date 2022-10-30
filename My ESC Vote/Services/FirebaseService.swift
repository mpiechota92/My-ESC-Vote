//
//  FirebaseService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import Foundation
import FirebaseCore
import FirebaseAuth

struct FirebaseService {
	
	static func login(email: String, password: String) -> Bool {
		
		guard ValidationHelper.validateEmail(email) else { return false }
		
		var isSuccessful = true
		
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				print(error.localizedDescription)
				isSuccessful = false
			} else {
				print(authResult ?? "successfully logged in")
				isSuccessful = true
			}
		}
		
		return isSuccessful
	}
	
	static func logOut() -> Bool {
		
		do {
			try Auth.auth().signOut()
			return true
		} catch {
			print(error.localizedDescription)
			return false
		}
		
	}
	
	static func register(name: String, email: String, password: String, confirmPassword: String) -> Bool {
		
		guard password == confirmPassword,
			  ValidationHelper.validateEmail(email),
			  ValidationHelper.validatePassword(password) else {
			return false // Need to return an error
		}
		
		var isSuccessful = true
		
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if let error = error {
				print(error.localizedDescription)
				isSuccessful = false
			} else {
				print(result ?? "successfully registered")
				isSuccessful = true
			}
		}
		
		if !isSuccessful { return false }
		
		FirestoreService.setUserName(name, for: email) { isSuccessful in
			
		}
		
		return true
	}
	
	static func isLoggedIn() -> Bool {
		return Auth.auth().currentUser != nil
	}
	
	static func currentUserEmail() -> String? {
		return Auth.auth().currentUser?.email
	}
}
