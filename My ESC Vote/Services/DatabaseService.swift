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
	
	typealias Users = Constants.API.Firestore.Collections.Users
	
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
			Users.Fields.name: name,
			Users.Fields.email: email
		]
		
		var databaseError: DatabaseError?
		
		database.collection(Users.collectionName)
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
	
	internal func fetchAllData<T: Codable>(from collection: String) -> [T] {
		
		var data: [T] = []
		
		database.collection(collection).getDocuments { querySnapshot, error in
			guard error == nil else {
				print(error!)
				fatalError()
			}
			
			if let querySnapshot = querySnapshot {
				print(querySnapshot.count)
				for document in querySnapshot.documents {
					do {
						let record = try document.data(as: T.self)
						data.append(record)
						print(record)
					} catch {
						print(error.localizedDescription)
					}
				}
			}
		}
		
		return data
		
	}
	
	internal func fetchData<T: Codable>(for documentID: String, from collection: String) -> T? {
		
		var record: T?
		
		let docRef = database.collection(collection).document(documentID)
		
		docRef.getDocument(as: T.self) { result in
			switch result {
			case .success(let item):
				record = item
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
		
		return record
		
	}
	
	internal func saveData<T: Encodable>(_ data: T, to collection: String) throws where T : HasDocumentID {
		guard let id = data.getID() else {
			print("KUPA")
			return
		}
		
		try database.collection(collection).document(id).setData(from: data)
	}
}
