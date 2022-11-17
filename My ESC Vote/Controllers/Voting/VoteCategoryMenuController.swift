//
//  MenuController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 07/11/2022.
//

import UIKit
import SnapKit

class VoteCategoryMenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	
	fileprivate let cellID = "VoteMenuCellID"
	fileprivate let menuItems = ["Favourite", "Vocals", "Performence"]
	
	var delegate: VoteCategoryMenuControllerDelegate?
	
	let menuBar: UIView = {
		let view = UIView()
		view.backgroundColor = Color.accentColor
		return view
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupCollectionView()
    }

	func setupCollectionView() {
		
		collectionView.backgroundColor = Constants.Design.Color.Primary.darkNavy
		collectionView.allowsSelection = true
		collectionView.register(VoteMenuCell.self, forCellWithReuseIdentifier: cellID)
		
		if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
			layout.scrollDirection = .horizontal
			layout.minimumLineSpacing = 0
			layout.minimumInteritemSpacing = 0
		}
		
		view.addSubview(menuBar)
		
		menuBar.snp.makeConstraints { make in
			make.top.equalTo(collectionView)
		}
		
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.didTapMenuItem(at: indexPath)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return menuItems.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! VoteMenuCell
		cell.menuTitleLabel.text = menuItems[indexPath.item]
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = view.frame.width
		return .init(width: width/CGFloat(menuItems.count), height: view.frame.height)
	}
	
}

protocol VoteCategoryMenuControllerDelegate {
	func didTapMenuItem(at indexPath: IndexPath)
}
