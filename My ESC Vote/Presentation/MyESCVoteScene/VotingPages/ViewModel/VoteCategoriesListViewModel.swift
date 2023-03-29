//
//  ContestVotingViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 26/11/2022.
//

import Foundation

protocol VoteCategoriesListViewModelInput {

}

protocol VoteCategoriesListViewModelOutput {
	var items: [VoteCategoriesListItemViewModel] { get }
	func item(for: IndexPath) -> VoteCategoriesListItemViewModel
	func numberOfItems(in section: Int) -> Int
}

protocol VoteCategoriesListViewModel: VoteCategoriesListViewModelInput, VoteCategoriesListViewModelOutput {}

struct VoteCategoriesListViewModelParams {
	var categories: [VoteCategory]
	var contest: Contest
}

final class DefaultVoteCategoriesListViewModel: VoteCategoriesListViewModel {
	
	internal var items: [VoteCategoriesListItemViewModel] = []
	
	init() {}
	
//	init(with params: VoteCategoriesListViewModelParams) {
//		items = params.categories.map({VoteCategoriesListItemViewModel.init(category: $0, contest: params.contest)})
//	}
//
//	init(for categories: [VoteCategory], in contest: Contest) {
//		items = categories.map({VoteCategoriesListItemViewModel.init(category: $0, contest: contest)})
//	}
	
	func item(for indexPath: IndexPath) -> VoteCategoriesListItemViewModel {
		return items[indexPath.item]
	}
	
	func numberOfItems(in section: Int) -> Int {
		return items.count
	}
	
	func setup(with params: VoteCategoriesListViewModelParams) {
		items = params.categories.map({VoteCategoriesListItemViewModel.init(category: $0, contest: params.contest)})
	}
}
