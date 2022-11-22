//
//  VoteCategoryPageCell.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

class VoteCategoryPageCell: UICollectionViewCell {
    

	static let identifier = "VoteCategoryPageCell"
	
	static func nib() -> UINib {
		return UINib(nibName: "VoteCategoryPageCell",
					 bundle: nil)
	}
	
	@IBOutlet var countriesVoteTableView: UITableView!
	
	var countryListViewModel: CountryListViewModel!
	
	var view: UIView!
	func setupView(for superView: UIView) {
		
	}
	
	override func awakeFromNib() {
		print("Kupaaaa")
		countriesVoteTableView.delegate = self
		countriesVoteTableView.dataSource = self
	}
	
	func setupPageCell() {

		countriesVoteTableView.estimatedRowHeight = UITableView.automaticDimension
		countriesVoteTableView.rowHeight = UITableView.automaticDimension
		countriesVoteTableView.register(CountryVoteCell.nib(), forCellReuseIdentifier: CountryVoteCell.identifier)
		print(contentView.frame)
		
		countriesVoteTableView.snp.makeConstraints { make in
			make.top.equalTo(contentView).offset(80)
		}
		
		countriesVoteTableView.reloadData()
	}

}

extension VoteCategoryPageCell: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
}

extension VoteCategoryPageCell: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countryListViewModel.countryCount
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CountryVoteCell.identifier, for: indexPath) as! CountryVoteCell
		
		cell.viewModel = countryListViewModel.countryViewModelAt(index: indexPath.row)
		
		return cell
	}
	
}
