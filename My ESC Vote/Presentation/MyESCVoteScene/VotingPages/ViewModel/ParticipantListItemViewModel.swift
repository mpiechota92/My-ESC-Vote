//
//  ParticipantListItemViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 25/11/2022.
//

import Foundation

struct ParticipantListItemViewModel {
	let countryName: String
	let artist: String
	let song: String
	var order: Int
	var place: Int = 0
}

extension ParticipantListItemViewModel {
	
	init(participant: Participant) {
		self.countryName = participant.countryName
		self.artist = participant.artist
		self.song = participant.song
		self.order = participant.order
	}
	
	var points: String {
		var _points: Int
		
		switch place {
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
		
		return String(_points)
	}
	
}
