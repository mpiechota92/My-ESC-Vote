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

protocol VoteCategoriesListViewModel: VoteCategoriesListViewModelInput,
										VoteCategoriesListViewModelOutput {}


final class DefaultVoteCategoriesListViewModel: VoteCategoriesListViewModel {
	
	internal var items: [VoteCategoriesListItemViewModel]
	
	init(for categories: [VoteCategory]) {
		items = categories.map({VoteCategoriesListItemViewModel.init(category: $0)})
	}
	
	func item(for indexPath: IndexPath) -> VoteCategoriesListItemViewModel {
		return items[indexPath.item]
	}
	
	func numberOfItems(in section: Int) -> Int {
		return items.count
	}
}
