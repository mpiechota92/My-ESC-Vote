//
//  AboutInfoView.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 04/11/2022.
//

import UIKit
import SnapKit

class InfoView: UIView, HavingNib {
	
	private weak var targetViewController: UIViewController!
	private var backgroundView: UIView!
	
	@IBOutlet private weak var dismissButton: UIButton!
	@IBOutlet private weak var contentView: UIView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var textLabel: UILabel!
	
	@IBOutlet weak var button2: UIButton!
	
	func with(title: String, text: String) -> InfoView {
		self.titleLabel.text = title
		self.textLabel.text = text
		
		return self
	}
	
	func with(titleFont fontName: String, size: CGFloat) -> InfoView? {
		guard let font = UIFont(name: fontName, size: size) else { return nil }
		
		self.titleLabel.font = font
		
		return self
	}
	
	func with(textFont fontName: String, size: CGFloat) -> InfoView? {
		guard let font = UIFont(name: fontName, size: size) else { return nil }
		
		self.textLabel.font = font
		
		return self
	}
	
	func with(target targetViewController: UIViewController) -> InfoView? {
		self.targetViewController = targetViewController
		
		guard let contentView = self.targetViewController.view else { return nil }
		
		
		backgroundView = UIView()
		backgroundView.frame = targetViewController.view.bounds
		backgroundView.backgroundColor = .black
		backgroundView.alpha = 0.8
		//targetViewController.view.addSubview(backgroundView)
		//targetViewController.view.addSubview(self)
		
		let button = UIButton(frame: CGRect(x: self.frame.midX, y: self.frame.midY, width: 50, height: 50))
		button.titleLabel?.text = "KUPA"
		button.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
		self.addSubview(button)
		
		self.snp.makeConstraints { make in
			make.centerX.equalTo(contentView).offset(-self.frame.width / 2.0)
			make.centerY.equalTo(contentView).offset(-self.frame.height / 2.0)
		}
		self.dismissButton.addTarget(self,
									 action: #selector(didTapDismissButton),
									 for: .touchUpInside)
		
		self.button2.addTarget(self.targetViewController,
									 action: #selector(didTapDismissButton),
									 for: .touchUpInside)
		
		return self
	}
	
	func withButton(_ action: Selector? = nil) -> InfoView {
		
		return self
	}
	
	func show() {
		self.isHidden = false
		self.contentView.layer.cornerRadius = self.frame.height / 10
		
		//self.alpha = 0.95
	}
	
	@objc func didTapDismissButton() {
		guard let target = targetViewController else { return }
		print("kupa")
		self.removeFromSuperview()
	}
	
	func hide() {
		self.isHidden = true
	}
}
