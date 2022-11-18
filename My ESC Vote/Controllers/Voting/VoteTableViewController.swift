//
//  VoteTableViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 17/11/2022.
//

import UIKit

enum VoteCategory: String, Codable, CaseIterable {
	case favourite = "Favourite"
	case vocals = "Vocals"
	case performance = "Performance"
}

class VoteTableViewController: UITableViewController {
	
	var viewModel: CountryVoteListViewModel!
	var voteCategory: VoteCategory?
	var contest: Contest?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(UINib(nibName: Constants.Content.Nib.countryVoteCell, bundle: nil),
						   forCellReuseIdentifier: Constants.UI.TableView.Cell.vote)
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.countryCount
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UI.TableView.Cell.vote, for: indexPath) as! CountryVoteCell
		
		let country = viewModel.countryAt(index: indexPath.row)
		cell.artistNameLabel.text = country.artist
		cell.songNameLabel.text = country.song
		
		// TODO: image for a country
		
		return cell
	}
}
