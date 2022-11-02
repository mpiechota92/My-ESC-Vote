//
//  FirestoreService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

enum DatabaseError: String, Error {
	
	case nameTooLong = "Name cannot exceed 16 characters"
	case addDocumentFailure = "Error adding document to the database"
	
}

extension DatabaseError: LocalizedError {
	
	public var localizedDescription: String? {
		switch self {
		case .nameTooLong:
			return DatabaseError.nameTooLong.rawValue
		case .addDocumentFailure:
			return DatabaseError.addDocumentFailure.rawValue
		}
	}
	
}

class DatabaseService {
	
	// MARK: Vars & Lets
	
	private weak var database: Firestore!
	
	// MARK: Init
	
	init(with database: Firestore) {
		self.database = database
	}
	
	// MARK: Public funcs
	
	internal func setUserName(_ name: String, for email: String, completion: ((_ error: DatabaseError?) -> ())? = nil) throws {
		guard name.count < 16 else {
			completion?(.nameTooLong)
			throw DatabaseError.nameTooLong
		}
		
		let data = [
			Constants.API.Firestore.Collections.Users.Fields.name: name,
			Constants.API.Firestore.Collections.Users.Fields.email: email
		]
			
		var databaseError: DatabaseError?
		
		database.collection(Constants.API.Firestore.Collections.Users.tableName)
			.document(email)
			.setData(data) { error in
			if let error = error {
				print(error.localizedDescription)
				completion?(.addDocumentFailure)
				databaseError = .addDocumentFailure
			} else {
				print("Successfully set User name.")
				completion?(nil)
			}
		}
		
		if let error = databaseError {
			throw error
		}
	}
	
}
