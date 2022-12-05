//
//  LoadingIndicator.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 26/11/2022.
//

import UIKit

class LoadingIndicator {
	
	static var indicator: UIActivityIndicatorView?
	
	static func start(for view: UIView) {
		
		DispatchQueue.main.async {
			if indicator != nil { return }
			
			let indicator = UIActivityIndicatorView(frame: view.frame)
			indicator.backgroundColor = UIColor.black.withAlphaComponent(0.1)
			indicator.style = .large
			
			view.addSubview(indicator)
			indicator.startAnimating()
			self.indicator = indicator
		}
		
	}
	
	static func end() {
		DispatchQueue.main.async {
			guard let indicator = indicator else { return }
			indicator.stopAnimating()
			indicator.removeFromSuperview()
			self.indicator = nil
		}
	}
	
}
