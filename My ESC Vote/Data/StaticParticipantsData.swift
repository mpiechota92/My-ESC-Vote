//
//  StaticParticipantsData.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 03/12/2022.
//

import Foundation

enum ParticipantsStaticDataProvider {}

protocol ContestData {
	static func getParticipantsData() -> [Participant]
	static var title: String { get }
}

extension ContestData {
	
	static var title: String {
		return String(describing: Self.self)
	}
	
}

extension ParticipantsStaticDataProvider {
	static func getContestData(contest: Contest) -> [Participant]? {

		switch contest.title {
		case JESC2022.title:
			return JESC2022.getParticipantsData()
		default:
			return nil
		}
		
	}
}
