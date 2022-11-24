//
//  APIConstants.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//

extension Constants {
	
	enum API {
		
		enum Firestore {
			
			enum Collections {
				
				enum Users {
					static let collectionName = "users"
					
					enum Fields {
						static let name = "name"
						static let email = "email"
					}
				}
				
				enum Contests {
					static let collectionName = "contests"
					
					enum Fields {
						static let name = "name"
						static let email = "email"
					}
				}
			}
			
		}
		
	}
	
}


