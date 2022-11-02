//
//  UserViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 01/11/2022.
//

import Foundation

class RegistrationFormViewModel {
	
	typealias RegistrationHandler = (_ error: Error?) -> ()
	
	func registerNewUser(name: String, email: String, password: String, confirmPassword: String, handler: @escaping RegistrationHandler) {
		
		let registrationForm = RegistrationForm(name: name, email: email, password: password, confirmPassword: confirmPassword)
		
		print(name, email, password, confirmPassword, separator: " - ", terminator: ";")
		
		do {
			try registrationForm.createUser()
			handler(nil)
		} catch {
			handler(error)
		}
		
	}
	
}
