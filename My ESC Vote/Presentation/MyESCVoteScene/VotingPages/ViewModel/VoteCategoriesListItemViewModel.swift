//
//  VotingCategoriesListItemViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 26/11/2022.
//

import Foundation

enum VoteCategory: String, CategoryProtocol {
	case favourite = "Favourite"
	case vocals = "Vocals"
	case performance = "Performance"
	
	var simpleDescription: String {
		return self.rawValue
	}
}

struct VoteCategoriesListItemViewModel {
	let category: VoteCategory
	let contest: Contest
}

extension VoteCategoriesListItemViewModel {
	
}
