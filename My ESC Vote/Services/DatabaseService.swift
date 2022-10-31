//
//  FirestoreService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

enum DatabaseError: Error {
	
	case nameTooLong
	case addDocumentFailure
	
}

class DatabaseService {
	
	// MARK: Vars & Lets
	
	private weak var database: Firestore!
	
	// MARK: Init
	
	init(with database: Firestore) {
		self.database = database
	}
	
	// MARK: Public funcs
	
	internal func setUserName(_ name: String, for email: String, completion: @escaping (_ error: DatabaseError?) -> ()) {
		guard name.count < 16 else {
			completion(.nameTooLong)
			return
		}
		
		let data = [
			Constants.API.Firestore.Collections.Users.Fields.name: name,
			Constants.API.Firestore.Collections.Users.Fields.email: email
		]
		
		database.collection(Constants.API.Firestore.Collections.Users.tableName).addDocument(data: data) { error in
			if let error = error {
				print(error.localizedDescription)
				completion(.addDocumentFailure)
			} else {
				print("Successfully set User name.")
				completion(nil)
			}
		}
		
	}
	
}
