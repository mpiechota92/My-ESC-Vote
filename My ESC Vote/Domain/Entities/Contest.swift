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
	case ESCS1 = "ESCS1"
	case ESCS2 = "ESCS2"
	case ESC2023 = "ESC 2023"
}

enum ContestCategory: String, CategoryProtocol {
	case ESCFinal = "Final"
	case ESCSemi1 = "1st Semi-final"
	case ESCSemi2 = "2nd Semi-final"
	
	var simpleDescription: String {
		return self.rawValue
	}
}

struct Contest: Codable {
	@DocumentID var title: String?
	var startDate: Date
	private var _country: String
	private var _contestType: String
	
	var contestType: ContestType? {
		return ContestType(rawValue: self._contestType)
	}
	
	var country: CountryName? {
		return CountryName(rawValue: self._country)
	}
	
	init(title: String, startDate: Date, country: CountryName, contestType: ContestType) {
		self.title = title
		self._country = country.rawValue
		self.startDate = startDate
		self._contestType = contestType.rawValue
	}
	
	enum CodingKeys: String, CodingKey {
		case title
		case startDate
		case _country = "country"
		case _contestType = "contestType"
	}
	
	static func getMock() -> Self {
		return self.init(title: "", startDate: Date(), country: .Albania, contestType: .ESC)
	}
}

extension Contest {
	func getID() -> String? {
		return title
	}
}
