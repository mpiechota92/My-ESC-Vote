//
//  CountryVoteViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import Foundation

protocol ParticipantsListViewModelInput {
	func insertItem(_ item: ParticipantsListItemViewModel, at indexPath: IndexPath)
}

protocol ParticipantsListViewModelOutput {
	func item(for indexPath: IndexPath) -> ParticipantsListItemViewModel
	func numberOfRows(in section: Int) -> Int
	func removeItem(at indexPath: IndexPath) -> ParticipantsListItemViewModel
	var voteCategory: VoteCategory { get }
	var updateItems: Observable<Bool> { get }
}

protocol ParticipantsListViewModel: ParticipantsListViewModelInput, ParticipantsListViewModelOutput {}

class DefaultParticipantsListViewModel: ParticipantsListViewModel {
	
	private var participants: [ParticipantsListItemViewModel] = []
	
	let updateItems: Observable<Bool> = Observable(true)
	var voteCategory: VoteCategory
	
	init(for contest: Contest, category: VoteCategory) {
		self.voteCategory = category
		
		//TODO: Get data about contestants
#if DEBUG
		mockData()
#endif
		
		bindParticipants()
	}
	
	func item(for indexPath: IndexPath) -> ParticipantsListItemViewModel {
		return participants[indexPath.row]
	}
	
	
	func insertItem(_ item: ParticipantsListItemViewModel, at indexPath: IndexPath) {
		participants.insert(item, at: indexPath.row)
		updateItems.value = true
	}
	
	func removeItem(at indexPath: IndexPath) -> ParticipantsListItemViewModel {
		return participants.remove(at: indexPath.row)
	}
	
	func numberOfRows(in section: Int) -> Int {
		return participants.count
	}
	
	// MARK: - Mock for now
	
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
		
		self.participants = countries.map(ParticipantsListItemViewModel.init)
		
		bindParticipants()
	}
	
	private func bindParticipants() {
		
		self.participants.forEach { participantViewModel in
			updateItems.observer(on: participantViewModel) { [weak self] updated in
				
				let index = self?.participants.firstIndex(where: { _participantViewModel in
					return participantViewModel == _participantViewModel
				})
				
				// Participant not found
				guard let index = index else { return }
				
				if updated {
					let oldValue = participantViewModel.place.value
					if oldValue != index {
						participantViewModel.place.value = index
					}
				}
				
			}
		}
		
	}
	
	deinit {
		self.participants.forEach { participantViewModel in
			self.updateItems.remove(observer: participantViewModel)
		}
	}
}

