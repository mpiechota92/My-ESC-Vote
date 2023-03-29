//
//  Country.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Participant: Codable {
	let countryName: CountryName
	@DocumentID var artist: String?
	let song: String
	var place: Int
	var order: Int
	var points: String = ""
	var imageURL: String = ""
	var info: String = ""
	
	enum CodingKeys: String, CodingKey {
		case artist = "artistName"
		case countryName
		case song = "songName"
		case place
		case order
		case points
		case imageURL
		case info
	}
}

extension Participant: Equatable {
	static func == (lhs: Participant, rhs: Participant) -> Bool {
		return (lhs.countryName == rhs.countryName) && (lhs.artist == rhs.artist) && (lhs.song == rhs.song)
	}
}

enum CountryName: String, Codable {
	case Albania = "Albania"
	case Andorra = "Andorra"
	case Armenia = "Armenia"
	case Australia = "Australia"
	case Austria = "Austria"
	case Azerbaijan = "Azerbaijan"
	case Belarus = "Belarus"
	case Belgium = "Belgium"
	case BosniaAndHerzegovina = "Bosnia and Herzegovina"
	case Bulgaria = "Bulgaria"
	case Canada = "Canada"
	case Croatia = "Croatia"
	case Cyprus = "Cyprus"
	case CzechRepublic = "Czech Republic"
	case Denmark = "Denmark"
	case Estonia = "Estonia"
	case Finland = "Finland"
	case France = "France"
	case Georgia = "Georgia"
	case Germany = "Germany"
	case Greece = "Greece"
	case Hungary = "Hungary"
	case Iceland = "Iceland"
	case Ireland = "Ireland"
	case Israel = "Israel"
	case Italy = "Italy"
	case Kazakhstan = "Kazakhstan"
	case Latvia = "Latvia"
	case Lithuania = "Lithuania"
	case Luxembourg = "Luxembourg"
	case Malta = "Malta"
	case Moldova = "Moldova"
	case Monaco = "Monaco"
	case Montenegro = "Montenegro"
	case Morocco = "Morocco"
	case Netherlands = "Netherlands"
	case NorthMacedonia = "North Macedonia"
	case Norway = "Norway"
	case Poland = "Poland"
	case Portugal = "Portugal"
	case Romania = "Romania"
	case Russia = "Russia"
	case SanMarino = "San Marino"
	case Scotland = "Scotland"
	case Serbia = "Serbia"
	case Slovakia = "Slovakia"
	case Slovenia = "Slovenia"
	case Spain = "Spain"
	case Sweden = "Sweden"
	case Switzerland = "Switzerland"
	case Turkey = "Turkey"
	case Ukraine = "Ukraine"
	case UnitedKingdom = "United Kingdom"
	case Wales = "Wales"
	case Yugoslavia = "Yugoslavia"
	
	// MARK: - Extra
	case Rainbow = "Rainbow"
	case EU = "European Union"
}
