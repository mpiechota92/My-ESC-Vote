//
//  ParticipantListItemViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 25/11/2022.
//

import UIKit

class ParticipantsListItemViewModel {
	let countryName: String
	let artist: String
	let song: String
	let order: String
	var place: Observable<Int>
	
	init(participant: Participant) {
		self.countryName = participant.countryName
		self.artist = participant.artist
		self.song = participant.song
		self.order = participant.order < 10 ? "0\(participant.order)" : "\(participant.order)"
		self.place = Observable(participant.place)
	}
}

extension ParticipantsListItemViewModel {

	var points: String {
		var _points: Int
		
		switch self.place.value {
		case 0:
			_points = 12
		case 1:
			_points = 10
		case let _place where _place < 12 :
			_points = 10 - _place
			_points = _points < 0 ? 0 : _points
		default:
			_points = 0
		}
		
		return _points == 0 ? "" : "\(_points)"
	}
	
	var pointsColor: UIColor {
		switch self.place.value {
		case 0:
			return Color.Points.gold
		case 1:
			return Color.Points.silver
		case 2:
			return Color.Points.bronze
		default:
			return Color.Points.regular
		}
	}
	
}

extension ParticipantsListItemViewModel: Equatable {
	
	static func == (lhs: ParticipantsListItemViewModel, rhs: ParticipantsListItemViewModel) -> Bool {
		return (lhs.countryName == rhs.countryName) && (lhs.artist == rhs.artist)
	}
	
}
