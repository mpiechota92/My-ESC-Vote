//
//  VotingService.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 06/03/2023.
//

import Foundation
import PromiseKit
import FirebaseFirestore

protocol VotingServiceProtocol {
	func vote(for contest: Contest, with vote: Vote) -> Promise<VotingStatus>
	//func hasVoted(contest: Contest, in category: String) -> Promise<Bool>
}

enum VotingError: Error {
	case wrongContestTitle
	case databaseMissing
	case notLoggedIn
	case wrongUserName
	case emailMissing
	case emptyContest
	case alreadyVoted
	case categoryMissing
	case setDataFailed
	case nilError
}

enum VotingStatus {
	case succesfful
	case alreadyVoted
	case failure
	case canVote
}

class VotingService: VotingServiceProtocol {
	
	func vote(for contest: Contest, with vote: Vote) -> Promise<VotingStatus> {
		return Promise { seal in
			hasVoted(contest: contest, in: vote.voteCategory)
			.done { [weak self] hasVoted in
				if hasVoted {
					seal.fulfill(.alreadyVoted)
				} else {
					if let result = self?.castVote(contest, vote) {
						switch result {
						case .success(let status):
							seal.fulfill(status)
						case .failure(let error):
							seal.reject(error)
						}
					} else {
						seal.reject(VotingError.nilError)
					}
				}
			}.catch { error in
				seal.reject(error)
			}
		}
	}

	private func castVote(_ contest: Contest, _ vote: Vote) -> Swift.Result<VotingStatus, VotingError> {
		guard let database = APIManager.shared().dbService.database else { return .failure(.databaseMissing) }
		guard let userName = vote.email else { return .failure(.emailMissing) }
		guard let contestName = contest.title else { return .failure(.emptyContest) }
		guard let voteCategory = vote.voteCategory else { return .failure(.categoryMissing) }
		
		let docRef = database
			.collection("Contests").document(contestName)
			.collection("Categories").document(voteCategory.rawValue)
			.collection("Votes").document(userName)
		
		do {
			try docRef.setData(from: vote)
			return .success(.succesfful)
		} catch {
			return .failure(.setDataFailed)
		}
	}
	
	
	func hasVoted(contest: Contest, completion: @escaping (Bool) -> ()) {
		guard let contestName = contest.title,
			  let database = APIManager.shared().dbService.database,
			  let userName = APIManager.shared().authService.currentUserEmail() else { return completion(true) }
		
		
		let docRef = database
			.collection("Contests").document(contestName)
			.collection("Votes").document(userName)
		
		docRef.getDocument { document, error in
			if let _ = document?.exists {
				completion(true)
			}

			if let _ = error {
				completion(true)
			}

			completion(false)
		}
	}
	
	private func hasVoted(contest: Contest, in category: VoteCategory?) -> Promise<Bool> {
		return Promise { seal in
			guard let contestName = contest.title else { return seal.reject(VotingError.wrongContestTitle) }
			guard let database = APIManager.shared().dbService.database else { return seal.reject(VotingError.databaseMissing) }
			guard let userName = APIManager.shared().authService.currentUserEmail() else { return seal.reject(VotingError.notLoggedIn) }
			guard let category = category else { return seal.reject(VotingError.categoryMissing) }
			
			let docRef = database
				.collection("Contests").document(contestName)
				.collection("Categories").document(category.rawValue)
				.collection("Votes").document(userName)
			
			docRef.getDocument { document, error in
				if let error = error {
					return seal.reject(error)
				}
				
				if document?.exists ?? false {
					return seal.resolve(.fulfilled(true))
				}

				return seal.resolve(.fulfilled(false))
			}
		}
	}
}
