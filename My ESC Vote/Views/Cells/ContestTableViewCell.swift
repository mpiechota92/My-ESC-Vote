//
//  ContestTableViewCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 09/11/2022.
//

import UIKit

class ContestTableViewCell: UITableViewCell {
	
	static let identifier = "ContestTableViewCell"
	
	var viewModel: ContestViewModel!
	var delegate: ContestTableViewCellDelegate?
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var countryLabel: UILabel!
	
	@IBOutlet weak var informationButton: UIButton!
	@IBOutlet weak var voteButton: UIButton!
	
	@IBOutlet weak var cellBackgroundView: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		titleLabel.font = UIFont(name: Font.Name.metropolisExtraBold, size: 10)
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func setup(with viewModel: ContestViewModel) {
		self.viewModel = viewModel
		
		cellBackgroundView.layer.cornerRadius = contentView.frame.size.height / 5

		
	}
	
	func setupLabels() {

	}
	
	func setupButtons() {

	}
	
	fileprivate func voteButtonTapped(_ action: UIAction) {
		delegate?.didTapVoteButton(forContest: viewModel.contest)
	}
	
	
	@IBAction func voteButtonTapped(_ sender: Any) {
		delegate?.didTapVoteButton(forContest: viewModel.contest)
	}
}


protocol ContestTableViewCellDelegate {
	
	func didTapVoteButton(forContest contest: Contest?)
	
}

