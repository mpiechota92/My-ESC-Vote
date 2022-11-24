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
			Country(name: CountryName.Albania, artist: "Kejtlin Gjata", song: "Pakëz diell", place: 0),
			Country(name: CountryName.Armenia, artist: "Nare", song: "Dance!", place: 0),
			Country(name: CountryName.France, artist: "Lissandro", song: "Oh maman!", place: 0),
			Country(name: CountryName.Georgia, artist: "Mariam Bigvava", song: "I Believe", place: 0),
			Country(name: CountryName.Ireland, artist: "Sophie Lennon", song: "Solas", place: 0),
			Country(name: CountryName.Italy, artist: "Chanel Dilecta", song: "Bla Bla Bla", place: 0),
			Country(name: CountryName.Kazakhstan, artist: "David Charlin", song: "Jer-Ana (Mother Earth)", place: 0),
			Country(name: CountryName.Malta, artist: "Gaia Gambuzza", song: "Diamonds in the Skies", place: 0),
			Country(name: CountryName.Netherlands, artist: "Luna", song: "La festa", place: 0),
			Country(name: CountryName.NorthMacedonia, artist: "Lara feat. Jovan and Irina", song: "Životot e pred mene", place: 0),
			Country(name: CountryName.Poland, artist: "Laura", song: "To the Moon", place: 0),
			Country(name: CountryName.Portugal, artist: "Nicolas Alves", song: "Anos 70", place: 0),
			Country(name: CountryName.Serbia, artist: "Katarina Savić", song: "Svet bez granica", place: 0),
			Country(name: CountryName.Spain, artist: "Carlos Higes", song: "Señorita", place: 0),
			Country(name: CountryName.Ukraine, artist: "Zlata Dziunka", song: "Nezlamna (Unbreakable)", place: 0),
			Country(name: CountryName.UnitedKingdom, artist: "Freya Skye", song: "Lose My Head", place: 0)
		]
		
		self.countryVotes = countries.map(CountryViewModel.init)
	}
	
	
	func countryViewModelAt(index: Int) -> CountryViewModel {
		return countryVotes[index]
	}
	
	func countryAt(index: Int) -> Country {
		return countryViewModelAt(index: index).country
	}
	
	func insertAt(_ country: CountryViewModel, index: Int) {
		self.countryVotes.insert(country, at: index)
	}
	
	func removeAt(index: Int) -> CountryViewModel {
		return countryVotes.remove(at: index)
	}
}

struct CountryViewModel {
	
	var country: Country
	
}
