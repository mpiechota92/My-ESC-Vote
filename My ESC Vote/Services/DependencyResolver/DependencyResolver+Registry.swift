//
//  DependencyResolver+Registry.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 24/03/2023.
//

import Foundation

extension DependencyResolver {
	func bootstrap() {
		if !self.registry.isEmpty {
			fatalError("Cannot bootstrap the resolver again.")
		}
		
		// MARK: - View Models
		
		self.register(ParticipantsListViewModel.self, DefaultParticipantsListViewModel.init)
		self.register(VoteCategoriesListViewModel.self, DefaultVoteCategoriesListViewModel.init)
		self.register(ContestantsListViewModel.self, BaseContestantsListViewModel.init)
	}
}
