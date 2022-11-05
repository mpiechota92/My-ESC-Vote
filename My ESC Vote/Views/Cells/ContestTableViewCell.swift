//
//  ContestTableViewCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 05/11/2022.
//

import UIKit

class ContestTableViewCell: UITableViewCell {
	
	@IBOutlet weak var contestTitleLabel: UILabel!
	
	var viewModel: ContestViewModel! {
		didSet {
			self.contestTitleLabel.text = viewModel.getContestTitle()
		}
	}
	
	
	@IBAction func voteButtonTapped(_ sender: UIButton) {
	}
	
	
	@IBAction func artistsInfoButtonTapped(_ sender: Any) {
	}
}
