//
//  CountryVoteViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import Foundation

class CountryVoteListViewModel {
	
	private var countryVotes: [CountryVoteViewModel]
	
	init(for contest: Contest) {
		
		countryVotes = contest.participants.map(CountryVoteViewModel.init)
		
	}
	
	func countryViewModelAt(index: Int) -> CountryVoteViewModel {
		return countryVotes[index]
	}
	
	func countryAt(index: Int) -> Country {
		return countryViewModelAt(index: index).country
	}
	
	func countryCount() -> Int {
		return countryVotes.count
	}
}

struct CountryVoteViewModel {
	
	var country: Country
	
}
