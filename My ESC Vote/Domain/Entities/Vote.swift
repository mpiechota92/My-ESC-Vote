//
//  Vote.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 06/03/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Vote: Codable {
	@DocumentID var email: String?
	private var _voteCategory: String
	private var _points: [String: Int]
	
	var voteCategory: VoteCategory? {
		return VoteCategory(rawValue: self._voteCategory)
	}
	
	var points: [CountryName: Int] {
		return _points.reduce(into: [CountryName: Int]()) { partialResult, element in
			if let countryName = CountryName(rawValue: element.key) {
				partialResult[countryName] = element.value
			}
		}
	}
	
	init(email: String? = nil, _voteCategory: String, _points: [String : Int]) {
		self.email = email
		self._voteCategory = _voteCategory
		self._points = _points
	}
	
	enum CodingKeys: String, CodingKey {
		case email
		case _voteCategory = "voteCategory"
		case _points = "points"
	}
}
