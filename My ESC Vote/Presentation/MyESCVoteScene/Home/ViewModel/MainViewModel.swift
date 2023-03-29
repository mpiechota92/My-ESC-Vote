//
//  MainViewModel.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 14/01/2023.
//

import Foundation

protocol MainViewModelInput {
	
}

protocol MainViewModelOutput {
	var earliestContest: Contest? { get }
}

protocol MainViewModel: MainViewModelInput, MainViewModelOutput {}

class DefaultMainViewModel: MainViewModel {
	
	var earliestContest: Contest?
	
	init() {
		//self.earliestContest = APIManager.shared().dbService.fetchEarliestContest()\
		earliestContest = nil
	}
	
}

