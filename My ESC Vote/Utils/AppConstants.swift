//
//  AppConstants.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 30/10/2022.
//

import Foundation
import UIKit

struct Constants {
	
	struct Design {
		
		struct Color {
			
			struct Primary {
				
			}
			
			struct Secondary {
				
			}
			
			struct Grayscale {
				
			}
			
		}
		
		struct Image {
			
			struct Icon {
				static let User = "person"
			}
			
		}
		
		struct Font {
			
		}
		
	}
	
	struct Content {
		
	}
	
	struct API {
		
		struct Firestore {
			
			struct Collections {
				
				struct Users {
					static let TableName = "users"
					
					struct Fields {
						static let Name = "name"
						static let Email = "email"
					}
				}
			}
			
		}
		
	}
	
}
