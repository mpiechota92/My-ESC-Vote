//
//  CountryVoteCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import UIKit

class ParticipantCell: UITableViewCell, HavingNib {
	
	// MARK: - IBOutlets
	
	@IBOutlet private var countryImageView: UIImageView!
	@IBOutlet private var songNameLabel: UILabel!
	@IBOutlet private var artistNameLabel: UILabel!
	@IBOutlet private var countryNameLabel: UILabel!
	@IBOutlet private var pointsLabel: UILabel!
	@IBOutlet private var orderLabel: UILabel!
	
	var viewModel: ParticipantsListItemViewModel!
	
	func fill(with viewModel: ParticipantsListItemViewModel) {
		self.viewModel = viewModel
		setupUI()
	}
	
	private func setupUI() {
		self.orderLabel.text = viewModel.order
		self.songNameLabel.text = viewModel.song
		self.artistNameLabel.text = viewModel.artist
		self.countryNameLabel.text = viewModel.countryName
		self.pointsLabel.text = viewModel.points
		self.pointsLabel.textColor = viewModel.pointsColor
		
		self.songNameLabel.font = UIFont(name: Font.Name.metropolisBold, size: Font.Size.large)
		self.orderLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.extraSmall)
		self.artistNameLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.medium)
		self.pointsLabel.font = UIFont(name: Font.Name.metropolisBold, size: Font.Size.extraLarge)
		self.countryNameLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.extraSmall)
		
		self.countryImageView.image = UIImage(named: viewModel.countryName)
	}
}
