//
//  AlertInfoViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 02/12/2022.
//

import UIKit

class AlertInfoViewController: UIViewController, HavingStoryboard {

	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var dismissButton: UIButton!
	
	@IBOutlet weak var rightButton: UIButton!
	@IBOutlet weak var leftButton: UIButton!
	
	private var menuButtonAnimation: (_ menuButton: MenuButton) -> Void = { button in
		let initialTransform = button.transform
		let scaledTransform = initialTransform.scaledBy(x: 2, y: 2)
		
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.5,
						   delay: 0,
						   usingSpringWithDamping: 0.6,
						   initialSpringVelocity: 1,
						   options: [.curveEaseIn]) {
				button.transform = scaledTransform
				button.tintColor = .yellow
			} completion: { done in
				if done {
					UIView.animate(withDuration: 1,
								   delay: 0,
								   usingSpringWithDamping: 0.6,
								   initialSpringVelocity: 1,
								   options: [.curveEaseIn]) {
						button.transform = initialTransform
						button.tintColor = Color.tintColor
					}
				}
				
			}
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setupUI()
    }

	private func setupUI() {
		let mediumThin = UIFont(name: Font.Name.metropolisThin, size: Font.Size.medium)!
		let largeBold = UIFont(name: Font.Name.metropolisBold, size: Font.Size.large)!
		let medium = UIFont(name: Font.Name.metropolisRegular, size: Font.Size.medium)!
		
		titleLabel.font = largeBold
		textLabel.font = mediumThin
		
		leftButton.titleLabel?.font = medium
		rightButton.titleLabel?.font = medium
		
		leftButton.isHidden = true
		rightButton.isHidden = true
		
		contentView.layer.cornerRadius = contentView.frame.height / 10
		contentView.alpha = 0
	}
	
	func setupWithButtons(left leftAction: Selector? = nil, right rightAction: Selector? = nil) {
		if let leftAction = leftAction {
			leftButton.isHidden = false
			leftButton.addTarget(self, action: leftAction, for: .touchUpInside)
		}
		
		if let rightAction = rightAction {
			rightButton.isHidden = false
			rightButton.addTarget(self, action: rightAction, for: .touchUpInside)
		}
	}
	
	func setupWith(_ viewController: UIViewController,
				   title: String, text: String,
				   menuButton: MenuButton? = nil,
				   leftButtonTitle: String? = nil, leftAction: Selector? = nil,
				   rightButtonTitle: String? = nil, rightAction: Selector? = nil) {
		
		viewController.addChild(self)
		self.view.frame = viewController.view.bounds
		viewController.view.addSubview(self.view)
		self.didMove(toParent: viewController)
		
		titleLabel.text = title
		textLabel.text = text
		
		if let menuButton = menuButton {
			menuButtonAnimation(menuButton)
		}
		
		if let leftButtonTitle = leftButtonTitle {
			self.leftButton.setTitle(leftButtonTitle, for: .normal)
			self.leftButton.isHidden = false
			
			if  let leftAction = leftAction {
				self.leftButton.addTarget(self, action: leftAction, for: .touchUpInside)
			} else {
				self.leftButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
			}
		}
		
		if let rightButtonTitle = rightButtonTitle, let rightAction = rightAction {
			self.rightButton.isHidden = false
			self.rightButton.setTitle(rightButtonTitle, for: .normal)
			self.rightButton.addTarget(self, action: rightAction, for: .touchUpInside)
		}
		
	}
	
	func show() {
		let initialTransform = contentView.transform
		contentView.transform = .identity.scaledBy(x: 0, y: 0)
		
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseIn]) {
				self.contentView.transform = initialTransform
				self.contentView.alpha = 1
				self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
			}
		}
	}
	
	@objc func dismiss(_ sender: Any? = nil) {
		let transform = contentView.transform
		let scaledTransform = transform.scaledBy(x: 0.1, y: 0.1)
		DispatchQueue.main.async {
			UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseOut]) {
				self.contentView.transform = scaledTransform
				self.contentView.alpha = 0
				self.view.alpha = 0
			} completion: { done in
				if done {
					self.view.removeFromSuperview()
					self.removeFromParent()
				}
			}
		}
	}

	
	@IBAction func didTapDismissButtonx(_ sender: Any) {
		dismiss()
	}
	
}
