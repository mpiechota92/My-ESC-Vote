//
//  DependencyContainer.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//

import Foundation
import FirebaseFirestore
import UIKit

class APIManager {
	
	// MARK: Vars & Lets
	
	private static var sharedAPIManager: APIManager = {
		let apiManager = APIManager()
		
		return apiManager
	}()
	
	// MARK: Firestore Database
	
	private lazy var firestoreDB: Firestore = Firestore.firestore()
	
	// MARK: Network Services:
	
	internal lazy var dbService = DatabaseService(with: firestoreDB)
	internal lazy var authService = AuthenticationService()
	
	// MARK: Accessor
	
	static func shared() -> APIManager {
		return sharedAPIManager
	}
}
