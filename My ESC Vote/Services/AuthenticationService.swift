//
//  AuthenticationService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//

import Foundation
import FirebaseAuth

enum AuthenticationError: Error {
	case passwordMismatch
	case invalidEmail
	case invalidPassword
	case userNameNotSet
	case userNotCreated
	case loginError
	case logoutError
}

class AuthenticationService {
	
	// MARK: Public funcs
	
	func register(name: String, email: String, password: String, confirmPassword: String, completion: @escaping (_ error: AuthenticationError?) -> ()) {
		
		guard password == confirmPassword else {
			completion(.passwordMismatch)
			return
		}
		guard ValidationHelper.validateEmail(email) else {
			completion(.invalidEmail)
			return
		}
		
		guard ValidationHelper.validatePassword(password) else {
			completion(.invalidPassword)
			return
		}
		
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if let error = error {
				print(error.localizedDescription)
				completion(.userNotCreated)
			} else {
				print(result ?? "successfully registered")
				completion(nil)
			}
		}
	}
	
	func login(email: String, password: String, completion: @escaping (_ error: AuthenticationError?) -> ()) {
		
		guard ValidationHelper.validateEmail(email) else {
			completion(.invalidEmail)
			return
		}
		
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				print(error.localizedDescription)
				completion(.loginError)
			} else {
				print(authResult ?? "successfully logged in")
				completion(nil)
			}
		}
		
	}
	
	func logOut(completion: @escaping (_ error: AuthenticationError?) -> ()) {
		
		do {
			try Auth.auth().signOut()
			completion(nil)
		} catch {
			print(error.localizedDescription)
			completion(.logoutError)
		}
		
	}
	
	func isLoggedIn() -> Bool {
		return Auth.auth().currentUser != nil
	}
	
	func currentUserEmail() -> String? {
		return Auth.auth().currentUser?.email
	}
	
}
