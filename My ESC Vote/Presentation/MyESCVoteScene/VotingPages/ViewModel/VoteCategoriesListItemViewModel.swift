//
//  VotingCategoriesListItemViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 26/11/2022.
//

import Foundation

enum VoteCategory: String, Codable, CaseIterable {
	case favourite = "Favourite"
	case vocals = "Vocals"
	case performance = "Performance"
}

struct VoteCategoriesListItemViewModel {
	let category: VoteCategory
	let contest: Contest
}

extension VoteCategoriesListItemViewModel {
	
}
