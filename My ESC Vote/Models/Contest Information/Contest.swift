//
//  Contest.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 05/11/2022.
//

import Foundation
import FirebaseFirestoreSwift

enum ContestType: String, Codable {
	case ESC = "ESC"
	case JSEC = "JSEC"
}

struct Contest: Codable, HasDocumentID {
	
	@DocumentID var title: String?
	var country: String
	var startDate: Date
	var endDate: Date
	var contestType: ContestType
	
}

extension Contest {
	func getID() -> String? {
		return title
	}
}
