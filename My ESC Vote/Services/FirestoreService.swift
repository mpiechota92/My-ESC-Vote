//
//  FirestoreService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


struct FirestoreService {
	
	private static weak var db: Firestore? = {
		Firestore.firestore()
	}()
	
	static func setUserName(_ name: String, for email: String, completion: @escaping (_ isSuccessful: Bool) -> ()) {
		guard let db = db, name.count < 16 else {
			completion(false)
			return
		}
		
		let data = [
			Constants.API.Firestore.Collections.Users.Fields.Name: name,
			Constants.API.Firestore.Collections.Users.Fields.Email: email
		]
		
		db.collection(Constants.API.Firestore.Collections.Users.TableName).addDocument(data: data) { error in
			if let error = error {
				print(error.localizedDescription)
				completion(false)
			} else {
				print("Successfully set User name.")
				completion(true)
			}
		}
		
	}
	
}
