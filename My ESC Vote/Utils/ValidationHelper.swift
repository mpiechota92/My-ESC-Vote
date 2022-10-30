//
//  FirebaseUtils.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import Foundation

enum ValidationError: String, Error {
	case passwordNotLongEnough = "Password not long enough. Must be at least 7 characters long."
	case passwordsDoNotMatch = "Passwords do not match."
	case incorrectEmail = "Email is incorrect."
}

struct ValidationHelper {
	
	static func validatePassword(_ password: String) -> Bool {
		
		if password.count < 7 {
			return false
		}
		
		// At least one digit
		if password.range(of: #"\d+"#, options: .regularExpression) == nil {
			return false
		}
		
		// At least one non-capitalized and capitalized character
		if password.range(of: #"[a-z]+"#, options: .regularExpression) == nil &&
			password.range(of: #"[A-Z]+"#, options: .regularExpression) == nil {
			return false
		}
		
		// No whitespaces
		if password.range(of: #"\s+"#, options: .regularExpression) != nil {
			return false
		}
		
		// At least on special character
		if password.range(of: #"[!@#$%^&*]+"#, options: .regularExpression) == nil {
			return false
		}
		
		return true
	}
	
	static func validateEmail(_ email: String) -> Bool {
		let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$")
		
		return emailPredicate.evaluate(with: email)
	}
}
