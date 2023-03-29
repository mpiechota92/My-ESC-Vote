//
//  ContestantsListViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 20/03/2023.
//

import Foundation

protocol ContestantsListViewModelInput {
	
}

protocol ContestantsListViewModelOutput {
	func item(for indexPath: IndexPath) -> ContestantListItemViewModel
	func numberOfRows(in section: Int) -> Int
	
	func setup(with params: ContestantsListViewModelParams)
}

protocol ContestantsListViewModel: ContestantsListViewModelInput, ContestantsListViewModelOutput { }

struct ContestantsListViewModelParams {
	
}

class BaseContestantsListViewModel: ContestantsListViewModel {
	private var contestants: [ContestantListItemViewModel] = []
	
	func item(for indexPath: IndexPath) -> ContestantListItemViewModel {
		return contestants[indexPath.row]
	}
	
	func numberOfRows(in section: Int) -> Int {
		return contestants.count
	}
	
	func setup(with params: ContestantsListViewModelParams) {
		// TODO:
	}
}

class ContestantListItemViewModel {
	var participant: Participant
	var contest: Contest
	
	init(_ participant: Participant, _ contest: Contest) {
		self.participant = participant
		self.contest = contest
	}
}
