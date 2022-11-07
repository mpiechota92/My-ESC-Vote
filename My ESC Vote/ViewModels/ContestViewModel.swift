//
//  ContestViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 05/11/2022.
//

import Foundation

class ContestsListViewModel {
	
	private var contestsList: [ContestViewModel] = []
	
	func contestsCount() -> Int {
		return contestsList.count
	}
	
	func contestVMAtIndex(_ index: Int) -> ContestViewModel {
		return contestsList[index]
	}
	
	func fetchContestsData(completion: @escaping () -> ()) {
		
		APIManager.shared().dbService.fetchAllData(from: Collections.Contests.collectionName, as: Contest.self) { records in
			self.contestsList = records.map(ContestViewModel.init)
			completion()
		}
		
	}
	
}

struct ContestViewModel {
	
	private var contest: Contest
	
	init(contest: Contest) {
		self.contest = contest
	}
	
	func getContestTitle() -> String? {
		return contest.title
	}
	
}
