//
//  CountryVoteViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import Foundation

protocol ParticipantsListViewModelInput {
	func insertItem(_ item: ParticipantViewModel, at indexPath: IndexPath)
	func updateData()
}

protocol ParticipantsListViewModelOutput {
	func item(for indexPath: IndexPath) -> ParticipantListItemViewModel
	func numberOfItems(in section: Int) -> Int
	func removeItem(at indexPath: IndexPath) -> ParticipantListItemViewModel
	var voteCategory: VoteCategory { get }
	var reloadItems: Observable<Bool> { get }
}

protocol ParticipantsListViewModel: ParticipantsListViewModelInput, ParticipantsListViewModelOutput {}

class DefaultParticipantsListViewModel: ParticipantsListViewModel {
	
	var reloadItems: Observable<Bool> = Observable(true)
	var participants: [Participant] = [] { didSet { reloadItems.value = true } }
	let voteCategory: VoteCategory!
	
	init(for contest: Contest, category: VoteCategory) {
		self.voteCategory = category
		
		//TODO: Get data about contestants
#if DEBUG
		mockData()
#endif
		
	}
	
	func item(for indexPath: IndexPath) -> ParticipantListItemViewModel {
		return .init(participant: participants[indexPath.row])
	}
	
	func modelAt(index: Int) -> ParticipantViewModel {
		return participants[index]
	}
	
	func participantAt(index: Int) -> Participant {
		return modelAt(index: index).participant
	}
	
	func insertAt(_ viewModel: ParticipantViewModel, index: Int) {
		self.participants.insert(viewModel, at: index)
	}
	
	func removeAt(index: Int) -> ParticipantViewModel {
		return participants.remove(at: index)
	}
	
	// Delete probably - update will happen through observing
	func updateData() {
		for (index, participant) in participants.enumerated() {
			participant.participant.order = index
		}
	}
	
	
	
	func mockData() {
		let countries: [Participant] = [
			Participant(countryName: CountryName.Albania, artist: "Kejtlin Gjata", song: "Pakëz diell", place: 0),
			Participant(countryName: CountryName.Armenia, artist: "Nare", song: "Dance!", place: 0),
			Participant(countryName: CountryName.France, artist: "Lissandro", song: "Oh maman!", place: 0),
			Participant(countryName: CountryName.Georgia, artist: "Mariam Bigvava", song: "I Believe", place: 0),
			Participant(countryName: CountryName.Ireland, artist: "Sophie Lennon", song: "Solas", place: 0),
			Participant(countryName: CountryName.Italy, artist: "Chanel Dilecta", song: "Bla Bla Bla", place: 0),
			Participant(countryName: CountryName.Kazakhstan, artist: "David Charlin", song: "Jer-Ana (Mother Earth)", place: 0),
			Participant(countryName: CountryName.Malta, artist: "Gaia Gambuzza", song: "Diamonds in the Skies", place: 0),
			Participant(countryName: CountryName.Netherlands, artist: "Luna", song: "La festa", place: 0),
			Participant(countryName: CountryName.NorthMacedonia, artist: "Lara feat. Jovan and Irina", song: "Životot e pred mene", place: 0),
			Participant(countryName: CountryName.Poland, artist: "Laura", song: "To the Moon", place: 0),
			Participant(countryName: CountryName.Portugal, artist: "Nicolas Alves", song: "Anos 70", place: 0),
			Participant(countryName: CountryName.Serbia, artist: "Katarina Savić", song: "Svet bez granica", place: 0),
			Participant(countryName: CountryName.Spain, artist: "Carlos Higes", song: "Señorita", place: 0),
			Participant(countryName: CountryName.Ukraine, artist: "Zlata Dziunka", song: "Nezlamna (Unbreakable)", place: 0),
			Participant(countryName: CountryName.UnitedKingdom, artist: "Freya Skye", song: "Lose My Head", place: 0)
		]
		
		self.participants = countries.map(ParticipantViewModel.init)
	}
	
}

