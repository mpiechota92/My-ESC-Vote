//
//  APIConstants.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//

extension Constants {
	
	struct API {
		
		struct Firestore {
			
			struct Collections {
				
				struct Users {
					static let tableName = "users"
					
					struct Fields {
						static let name = "name"
						static let email = "email"
					}
				}
			}
			
		}
		
	}
	
}
