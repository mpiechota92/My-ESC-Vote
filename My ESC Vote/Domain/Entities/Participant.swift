//
//  Country.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import Foundation

struct Participant: Codable {
	
	let countryName: String
	let artist: String
	let song: String
	var place: Int
	var order: Int
	var points: String = ""
	
}

extension Participant: Equatable {
	
	static func == (lhs: Participant, rhs: Participant) -> Bool {
		return (lhs.countryName == rhs.countryName) && (lhs.artist == rhs.artist) && (lhs.song == rhs.song)
	}
	
}

enum CountryName {
	
	static let Albania = "Albania"
	static let Andorra = "Andorra"
	static let Armenia = "Armenia"
	static let Australia = "Australia"
	static let Austria = "Austria"
	static let Azerbaijan = "Azerbaijan"
	static let Belarus = "Belarus"
	static let Belgium = "Belgium"
	static let BosniaAndHerzegovina = "Bosnia and Herzegovina"
	static let Bulgaria = "Bulgaria"
	static let Canada = "Canada"
	static let Croatia = "Croatia"
	static let Cyprus = "Cyprus"
	static let CzechRepublic = "Czech Republic"
	static let Denmark = "Denmark"
	static let Estonia = "Estonia"
	static let Finland = "Finland"
	static let France = "France"
	static let Georgia = "Georgia"
	static let Germany = "Germany"
	static let Greece = "Greece"
	static let Hungary = "Hungary"
	static let Iceland = "Iceland"
	static let Ireland = "Ireland"
	static let Israel = "Israel"
	static let Italy = "Italy"
	static let Kazakhstan = "Kazakhstan"
	static let Latvia = "Latvia"
	static let Lithuania = "Lithuania"
	static let Luxembourg = "Luxembourg"
	static let Malta = "Malta"
	static let Moldova = "Moldova"
	static let Monaco = "Monaco"
	static let Montenegro = "Montenegro"
	static let Morocco = "Morocco"
	static let Netherlands = "Netherlands"
	static let NorthMacedonia = "North Macedonia"
	static let Norway = "Norway"
	static let Poland = "Poland"
	static let Portugal = "Portugal"
	static let Romania = "Romania"
	static let Russia = "Russia"
	static let SanMarino = "San Marino"
	static let Scotland = "Scotland"
	static let Serbia = "Serbia"
	static let Slovakia = "Slovakia"
	static let Slovenia = "Slovenia"
	static let Spain = "Spain"
	static let Sweden = "Sweden"
	static let Switzerland = "Switzerland"
	static let Turkey = "Turkey"
	static let Ukraine = "Ukraine"
	static let UnitedKingdom = "United Kingdom"
	static let Wales = "Wales"
	static let Yugoslavia = "Yugoslavia"
	
	// MARK: - Extra
	static let Rainbow = "Rainbow"
	static let EU = "European Union"
	
}
