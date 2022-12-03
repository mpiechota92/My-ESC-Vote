//
//  JESC2022.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 03/12/2022.
//

import Foundation

extension ParticipantsStaticDataProvider {
	
	enum JESC2022: ContestData {
		
		static func getParticipantsData() -> [Participant] {
			let participants: [Participant] = [
				Participant(countryName: CountryName.Albania, artist: "Kejtlin Gjata", song: "Pakëz diell", place: 0, order: 1),
				Participant(countryName: CountryName.Armenia, artist: "Nare", song: "Dance!", place: 0, order: 2),
				Participant(countryName: CountryName.France, artist: "Lissandro", song: "Oh maman!", place: 0, order: 3),
				Participant(countryName: CountryName.Georgia, artist: "Mariam Bigvava", song: "I Believe", place: 0, order: 4),
				Participant(countryName: CountryName.Ireland, artist: "Sophie Lennon", song: "Solas", place: 0, order: 5),
				Participant(countryName: CountryName.Italy, artist: "Chanel Dilecta", song: "Bla Bla Bla", place: 0, order: 6),
				Participant(countryName: CountryName.Kazakhstan, artist: "David Charlin", song: "Jer-Ana (Mother Earth)", place: 0, order: 7),
				Participant(countryName: CountryName.Malta, artist: "Gaia Gambuzza", song: "Diamonds in the Skies", place: 0, order: 8),
				Participant(countryName: CountryName.Netherlands, artist: "Luna", song: "La festa", place: 0, order: 9),
				Participant(countryName: CountryName.NorthMacedonia, artist: "Lara feat. Jovan and Irina", song: "Životot e pred mene", place: 0, order: 10),
				Participant(countryName: CountryName.Poland, artist: "Laura", song: "To the Moon", place: 0, order: 11),
				Participant(countryName: CountryName.Portugal, artist: "Nicolas Alves", song: "Anos 70", place: 0, order: 12),
				Participant(countryName: CountryName.Serbia, artist: "Katarina Savić", song: "Svet bez granica", place: 0, order: 13),
				Participant(countryName: CountryName.Spain, artist: "Carlos Higes", song: "Señorita", place: 0, order: 14),
				Participant(countryName: CountryName.Ukraine, artist: "Zlata Dziunka", song: "Nezlamna (Unbreakable)", place: 0, order: 15),
				Participant(countryName: CountryName.UnitedKingdom, artist: "Freya Skye", song: "Lose My Head", place: 0, order: 16)
			]
			
			return participants
		}
		
	}
	
}
