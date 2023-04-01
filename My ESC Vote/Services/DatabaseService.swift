//
//  FirestoreService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import PromiseKit

enum DatabaseError: String, Error {
	case nameTooLong = "Name cannot exceed 16 characters"
	case addDocumentFailure = "Error adding document to the database"
	case noDocumentId = "No Document ID"
	case getDocumentFailure = "Get document failure"
}

extension DatabaseError: LocalizedError {
	
	public var localizedDescription: String? {
		switch self {
		case .nameTooLong:
			return DatabaseError.nameTooLong.rawValue
		case .addDocumentFailure:
			return DatabaseError.addDocumentFailure.rawValue
		case .noDocumentId:
			return DatabaseError.noDocumentId.rawValue
		default:
			return ""
		}
	}
	
}

class DatabaseService {
	
	typealias Users = Constants.API.Firestore.Collections.Users
	
	// MARK: - Vars & Lets
	
	private(set) var database: Firestore!
	
	// MARK: - Init
	
	init(with database: Firestore) {
		self.database = database
	}
	
	// MARK: - Public funcs
	
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
		
		// it will never throw an error
		if let error = databaseError {
			throw error
		}
	}
	
	internal func fetchAllData<T: Decodable>(from collection: String, as type: T.Type, completion: @escaping (_ records: [T]) -> ()) {
		
		var data: [T] = []
		
		database.collection(collection).getDocuments { querySnapshot, error in
			guard error == nil else { fatalError() }
			
			if let querySnapshot = querySnapshot {
				for document in querySnapshot.documents {
					do {
						let record = try document.data(as: T.self)
						data.append(record)
					} catch {
						print(error)
					}
				}
				
				completion(data)
			}
		}
	}
	
	internal func fetchAllData<T: Codable>(from collection: String, as type: T.Type) -> Promise<[T]?> {
		return Promise { seal in
			var data: [T] = []
			database.collection(collection).getDocuments { querySnapshot, error in
				guard error == nil else { return seal.reject(error!) }
				
				if let querySnapshot = querySnapshot {
					for document in querySnapshot.documents {
						do {
							let record = try document.data(as: T.self)
							data.append(record)
						} catch {
							seal.reject(error)
						}
					}
					
					seal.fulfill(data)
					return
				}
				
				seal.fulfill(nil)
			}
		}
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
	
	internal func fetchEarliestContest(completion: @escaping (Contest?) -> ()) {
		fetchAllData(from: "Contests", as: Contest.self) { records in
			let contest = records.max{ $0.startDate < $1.startDate }
			completion(contest)
		}
	}
	
	internal func fetchData<T: Codable>(as: T.Type, for documentID: String, path: String) -> Promise<T> {
		return Promise { seal in
			database.document("\(path)/\(documentID)").getDocument(as: T.self) { result in
				switch result {
				case .success(let record):
					seal.fulfill(record)
				case .failure(let error):
					seal.reject(error)
				}
			}
		}
	}
	
	internal func saveData<T: Encodable>(_ data: T, to collection: String) throws where T : HasDocumentID {
		guard let id = data.getID() else { return }
		
		try database.collection(collection).document(id).setData(from: data)
	}
	
	internal func saveData<T: Encodable>(_ data: T, to path: String) -> Promise<Bool> where T: HasDocumentID {
		return Promise { seal in
			guard let id = data.getID() else { return seal.reject(DatabaseError.noDocumentId) }

			do {
				try database.collection(path).document(id).setData(from: data)
				seal.fulfill(true)
			} catch {
				seal.reject(error)
			}
		}
	}
	
	internal func exists(_ docRef: DocumentReference) -> Promise<Bool> {
		return Promise { seal in
			docRef.getDocument { snapshot, error in
				if let error = error {
					seal.reject(error)
				}
				
				if snapshot?.exists ?? false {
					seal.fulfill(true)
				}
				
				seal.fulfill(false)
			}
		}
	}
}
