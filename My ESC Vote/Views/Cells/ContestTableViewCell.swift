//
//  ContestTableViewCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 09/11/2022.
//

import UIKit

class ContestTableViewCell: UITableViewCell {
	
	var viewModel: ContestViewModel!
	var delegate: ContestTableViewCellDelegate?
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var countryLabel: UILabel!
	
	@IBOutlet weak var informationButton: UIButton!
	@IBOutlet weak var voteButton: UIButton!
	
	@IBOutlet weak var cellBackgroundView: UIView!
	
//	private var titleLabel: UILabel = {
//		let label = UILabel()
//		label.font = UIFont(name: Font.Name.gothamBold, size: Font.Size.extraLarge)
//		return label
//	}()
//
//	private var countryLabel: UILabel = {
//		let label = UILabel()
//		label.font = UIFont(name: Font.Name.gotham, size: Font.Size.large)
//		return label
//	}()
//
//	private var voteButton: UIButton = {
//		let button = UIButton()
//		button.titleLabel?.font = UIFont(name: Font.Name.gotham, size: Font.Size.large)
//		button.titleLabel?.text = "Vote"
//		return button
//	}()
//
//	private var informationButton: UIButton = {
//		let button = UIButton()
//		button.titleLabel?.font = UIFont(name: Font.Name.gotham, size: Font.Size.large)
//		button.titleLabel?.text = "Information"
//		return button
//	}()
////
//	private var cellBackgroundView: UIView = {
//
//	}()
//
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func setup(with viewModel: ContestViewModel) {
		self.viewModel = viewModel
		
		cellBackgroundView.layer.cornerRadius = contentView.frame.size.height / 5
//		contentView.backgroundColor = Color.Secondary.lightNavy
//
//		contentView.snp.makeConstraints { make in
//
//		}
//
//		contentView.addSubview(titleLabel)
//		contentView.addSubview(countryLabel)
//		contentView.addSubview(voteButton)
//		contentView.addSubview(informationButton)
//
//		setupLabels()
//		setupButtons()
		
	}
	
	func setupLabels() {
		
//		titleLabel.snp.makeConstraints { make in
//			make.leading.top.equalToSuperview().inset(10.0)
//			make.width.equalTo(200.0)
//			make.height.equalTo(40)
//		}
//
//		countryLabel.snp.makeConstraints { make in
//			make.leading.top.equalTo(titleLabel).inset(10.0)
//			make.width.equalTo(100.0)
//			make.height.equalTo(40)
//		}
		
	}
	
	func setupButtons() {
//
//		voteButton.snp.makeConstraints { make in
//			make.trailing.equalToSuperview()
//			make.centerY.equalTo(titleLabel)
//			make.height.equalTo(40.0)
//			make.width.equalTo(60.0)
//		}
//
//		informationButton.snp.makeConstraints { make in
//			make.trailing.equalToSuperview()
//			make.centerY.equalTo(countryLabel)
//			make.height.equalTo(40.0)
//			make.width.equalTo(100.0)
//		}
//
//		voteButton.addAction(UIAction(handler: voteButtonTapped), for: .touchUpInside)
//
	}
	
	fileprivate func voteButtonTapped(_ action: UIAction) {
		delegate?.didTapVoteButton(forContest: viewModel.getContestTitle())
	}
	
	
	@IBAction func voteButtonTapped(_ sender: Any) {
		delegate?.didTapVoteButton(forContest: viewModel.getContestTitle())
	}
}


protocol ContestTableViewCellDelegate {
	
	func didTapVoteButton(forContest contestName: String?)
	
}

