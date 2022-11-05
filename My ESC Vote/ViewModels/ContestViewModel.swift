//
//  ContestViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 05/11/2022.
//

import Foundation

class ContestsListViewModel {
	
	private var contestsList: [ContestViewModel]!
	
	func contestsCount() -> Int {
		return contestsList.count
	}
	
	func contestVMAtIndex(_ index: Int) -> ContestViewModel {
		return contestsList[index]
	}
	
	func fetchContestsData() {
		
		let contests: [Contest] = APIManager.shared().dbService.fetchAllData(from: Constants.API.Firestore.Collections.Contests.collectionName)
		contestsList = contests.map(ContestViewModel.init)
		
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
