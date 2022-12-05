//
//  CountdownTimer.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 03/12/2022.
//

import UIKit

final class CountdownTimer: UIView, HavingNib {
	
	enum DateFormatError : Error {
		case FormatError
	}
	
	typealias Second = Int
	
	static var dateFormatter: DateFormatter {
		let format = "dd-MM-yyyy HH:mm:ss"
		let formatter = DateFormatter()
		formatter.dateFormat = format
		
		return formatter
	}
	
	@IBOutlet private weak var daysLabel: UILabel!
	@IBOutlet private weak var hoursLabel: UILabel!
	@IBOutlet private weak var minutesLabel: UILabel!
	@IBOutlet private weak var secondsLabel: UILabel!
	
	private var days: Int = 0 {
		didSet {
			self.daysLabel.text = String(days)
		}
	}
	private var hours: Int = 0 {
		didSet {
			let text = hours < 10 ? "0\(hours)" : "\(hours)"
			self.hoursLabel.text = text
		}
	}

	private var minutes: Int = 0 {
		didSet {
			let text = minutes < 10 ? "0\(minutes)" : "\(minutes)"
			self.minutesLabel.text = text
		}
	}

	private var seconds: Int = 0 {
		didSet {
			let text = seconds < 10 ? "0\(seconds)" : "\(seconds)"
			self.secondsLabel.text = text
		}
	}
	
	var timeInSeconds: Second! {
		willSet {
			self.seconds = newValue % 60
			self.minutes = (newValue / 60) % 60
			self.hours = (newValue / 3600) % 24
			self.days = (newValue / 3600) / 24
		}
	}
	var timer: Timer!
	
	/**Must be in "dd-MM-yyyy HH:mm:ss" format.*/
	var date: String!
	
	override func awakeFromNib() {
		super.awakeFromNib()

		let font = UIFont(name: Font.Name.metropolisMedium, size: Font.Size.extraExtraLarge)
		self.daysLabel.font = font
		self.hoursLabel.font = font
		self.minutesLabel.font = font
		self.secondsLabel.font = font

	}
	
	/**
	Setups a timer with specific date string.
	- *date* must be in "dd-MM-yyyy HH:mm:ss" format.
	*/
	func setupTimer(with date: String) throws {
		guard let date = CountdownTimer.dateFormatter.date(from: date) else { throw DateFormatError.FormatError }

		self.timeInSeconds = Second(date - Date())
		
		self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
			self.timeInSeconds -= 1
			
			if (self.timeInSeconds == 0) {
				timer.invalidate()
			}
		})
		
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initSubviews()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initSubviews()
	}
	
	private func initSubviews() {
		let nib = UINib(nibName: "CountdownTimer", bundle: nil)
		
		guard let view = nib.instantiate(withOwner: self).first as? UIView else { fatalError() }
		
		view.frame = bounds
		view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		
		addSubview(view)
	}
}

extension Date {
	
	static func - (lhs: Date, rhs: Date) -> TimeInterval {
		return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
	}
	
}
