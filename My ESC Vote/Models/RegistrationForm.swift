//
//  User.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 01/11/2022.
//

import Foundation

struct RegistrationForm {
	
	// MARK: Vars & Lets
	
	private let name: String
	private let email: String
	private let password: String
	private let confirmPassword: String
	
	// MARK: Initializer
	
	init(name: String, email: String, password: String, confirmPassword: String) {
		self.name = name
		self.email = email
		self.password = password
		self.confirmPassword = confirmPassword
	}
	
	// MARK: Public funcs
	
	func createUser() throws {
		
		do {
			
			try APIManager.shared().authService.register(
				email: self.email,
				password: self.password,
				confirmPassword: self.confirmPassword
			)
			
			try APIManager.shared().dbService.setUserName(
				self.name,
				for: self.email
			)
			
		} catch {
			throw error
		}
	}
	
}

