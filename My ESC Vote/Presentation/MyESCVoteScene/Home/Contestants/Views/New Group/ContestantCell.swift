//
//  ContestantCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 20/03/2023.
//

import UIKit

class ContestantCell: UITableViewCell, HavingNib {
	
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var songNameLabel: UILabel!
	@IBOutlet weak var artistNameLabel: UILabel!
	@IBOutlet weak var countryImageView: UIImageView!
	
	var viewModel: ContestantListItemViewModel!
	
	func fill(with viewModel: ContestantListItemViewModel) {
		self.viewModel = viewModel
		setupUI()
	}
	
	private func setupUI() {
		let participant = viewModel.participant
		self.songNameLabel.text = participant.song
		self.artistNameLabel.text = participant.artist
		self.countryNameLabel.text = participant.countryName.rawValue
		
		self.songNameLabel.font = UIFont(name: Font.Name.metropolisBold, size: Font.Size.large)
		self.artistNameLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.medium)
		self.countryNameLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.extraSmall)
		
		let service = APIManager.shared().imageService
		guard let contestName = viewModel.contest.contestType?.rawValue else { return }
		let country = participant.countryName.rawValue
		
		service.getImageFor(country: country, contest: contestName)
			.done { image in
				DispatchQueue.main.async {
					self.countryImageView.image = image
				}
			}.catch { error in
				print(error)
				DispatchQueue.main.async {
					self.countryImageView.image = UIImage(named: country)
				}
			}
	}
}
