//
//  CountryVoteCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 11/11/2022.
//

import UIKit

class ParticipantCell: UITableViewCell {
	
	static let estimatedRowHeight = 61.0
	static let identifier = "ParticipantCell"
	
	static func nib() -> UINib {
		return UINib(nibName: "ParticipantCell",
					 bundle: nil)
	}
	
	@IBOutlet weak var countryImageView: UIImageView!
	@IBOutlet weak var songNameLabel: UILabel!
	@IBOutlet weak var artistNameLabel: UILabel!
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var pointsLabel: UILabel!
	@IBOutlet weak var orderLabel: UILabel!
	
	var viewModel: ParticipantViewModel! {
		didSet {
			updateFromModel()
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		setupUI()
		
		NotificationCenter.default.addObserver(self, selector: #selector(dataDidChange), name: NSNotification.Name.participentDataDidChangeNotification, object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	@objc func dataDidChange(_ notification: Notification) {
		updateFromModel()
	}
		
	private func updateFromModel() {
		guard let viewModel = viewModel else { return }
		let participant = viewModel.participant
		
		DispatchQueue.main.async {
			self.songNameLabel.text = "" //viewModel.songName
			self.artistNameLabel.text = participant.artist
			self.countryNameLabel.text = participant.countryName
			self.countryImageView.image = UIImage(named: participant.countryName)
			self.pointsLabel.text = participant.points
			
		}
		
	}
	
	private func setupUI() {
		songNameLabel.font = UIFont(name: Font.Name.metropolisBold, size: Font.Size.large)
		artistNameLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.medium)
		countryNameLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.extraSmall)
		pointsLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.extraSmall)
		orderLabel.font = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.extraSmall)
	}
}
