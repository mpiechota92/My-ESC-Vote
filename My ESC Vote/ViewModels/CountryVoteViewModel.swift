//
//  CountryVoteViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import Foundation

class CountryListViewModel {
	
	private var countryVotes: [CountryViewModel] = []
	
	var voteCategory: VoteCategory!
	var countryCount: Int {
		get {
			return countryVotes.count
		}
	}
	
	init(for contest: Contest, category: VoteCategory) {
		self.voteCategory = category
		
		//TODO: Get data about contestants
		#if DEBUG
		mockData()
		#endif
		
	}
	
	func mockData() {
		let countries: [Country] = [
			Country(name: "Poland", song: "Kupa", artist: "Kayah", place: 0),
			Country(name: "Poland", song: "Kupa", artist: "Kayah", place: 1),
			Country(name: "Poland", song: "Kupa", artist: "Kayah", place: 2),
			Country(name: "Poland", song: "Kupa", artist: "Kayah", place: 3),
			Country(name: "Poland", song: "Kupa", artist: "Kayah", place: 4),
		]
		
		self.countryVotes = countries.map(CountryViewModel.init)
	}
	
	
	func countryViewModelAt(index: Int) -> CountryViewModel {
		return countryVotes[index]
	}
	
	func countryAt(index: Int) -> Country {
		return countryViewModelAt(index: index).country
	}
	
}

struct CountryViewModel {
	
	var country: Country
	
}
