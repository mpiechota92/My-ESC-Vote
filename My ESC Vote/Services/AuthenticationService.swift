//
//  AuthenticationService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//

import Foundation
import FirebaseAuth

enum AuthenticationError: String, Error {
	
	case passwordMismatch
	case invalidEmail
	case invalidPassword
	case userNotCreated
	case loginError = "Error logging in"
	case logoutError = "Error logging out"
	
}

extension AuthenticationError: LocalizedError {
	
	public var errorDescription: String? {
		switch self {
		case .passwordMismatch:
			return NSLocalizedString(
				"Passwords do not match",
				comment: "Password Mismatch"
			)
		case .invalidEmail:
			return NSLocalizedString(
				"Email is not valid",
				comment: "Invalid Email"
			)
		case .invalidPassword:
			return NSLocalizedString(
				"Password must consist of at least 7 characters, one big letter, one small letter, one digit, and one special character: !@#$%^&*",
				comment: "Invalid Password"
			)
		case .userNotCreated:
			return NSLocalizedString(
				"Error when creating user. Please try again or contact the Administrator",
				comment: "User not created"
			)
		case .loginError:
			return NSLocalizedString("Error logging in", comment: "")
		default:
			return ""
		}
	}
	
}


class AuthenticationService {
	
	// MARK: Public funcs
	
	func register(email: String, password: String, confirmPassword: String, completion: ((_ error: AuthenticationError?) -> ())? = nil) throws {
		
		guard ValidationHelper.validateEmail(email) else {
			completion?(.invalidEmail)
			throw AuthenticationError.invalidEmail
		}
		
		guard ValidationHelper.validatePassword(password) else {
			completion?(.invalidPassword)
			throw AuthenticationError.invalidPassword
		}
		
		guard password == confirmPassword else {
			completion?(.passwordMismatch)
			throw AuthenticationError.passwordMismatch
		}
		
		var authenticationError: AuthenticationError?
		
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if let error = error {
				print(error.localizedDescription)
				completion?(.userNotCreated)
				authenticationError = .userNotCreated
			} else {
				print(result ?? "successfully registered")
				completion?(nil)
				
				NotificationCenter.default.post(Notification(name: .onLoginStatusChangeNotification))
			}
		}
		
		if let error = authenticationError {
			throw error
		}
		
	}
	
	func login(email: String, password: String, completion: ((_ error: AuthenticationError?) -> ())? = nil) throws {
		
		guard ValidationHelper.validateEmail(email) else {
			completion?(.invalidEmail)
			throw AuthenticationError.invalidEmail
		}
		
		var authenticationError: AuthenticationError?
		
		Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
			if let error = error {
				print(error)
				print(error.localizedDescription)
				completion?(.loginError)
				authenticationError = .loginError
			} else {
				print(authResult ?? "successfully logged in")
				completion?(nil)
				
				NotificationCenter.default.post(Notification(name: .onLoginStatusChangeNotification))
			}
		}
		
		if let error = authenticationError {
			throw error
		}
		
	}
	
	func logOut(completion: @escaping (_ error: AuthenticationError?) -> ()) {
		
		do {
			try Auth.auth().signOut()
			completion(nil)
			
			NotificationCenter.default.post(Notification(name: .onLoginStatusChangeNotification))
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
