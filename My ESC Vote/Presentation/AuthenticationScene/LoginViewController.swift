//
//  LoginViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 02/11/2022.
//

import UIKit

class LoginViewController: UIViewController, HavingStoryboard {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var dismissButton: UIButton!
	@IBOutlet weak var loginButton: UIButton!
	
	@IBOutlet weak var errorLabelView: LabelView!
	
	weak var creator: DismissableDelegate!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registerObserversForTextFields()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		dismissableDelegate.willDismiss()
	}
	
	// Text fields must not be empty for login button to be enabled.
	private func registerObserversForTextFields() {
		
		let notificationGenerator: NotificationGenerator<UITextField> = { textField in
			let closure: (Notification) -> () = { _ in
				let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
				let textIsNotEmpty = textCount > 0
				
				DispatchQueue.main.async { [weak self] in
					self?.loginButton.isEnabled = textIsNotEmpty
				}
			}
			
			return closure
		}
		
		self.addObserversToSubviews(in: self.view, with: notificationGenerator, forName: UITextField.textDidChangeNotification)
		
	}
	
	@IBAction func loginButtonTapped(_ sender: UIButton) {
		
		guard let email = emailTextField.text,
			  let password = passwordTextField.text else {
			return
		}
		
		do {
			try APIManager.shared().authService.login(
				email: email,
				password: password) { [weak self] error in
					if let error = error as LocalizedError? {
						self?.setTextForLabel(from: error)
					} else {
						self?.navigationController?.popToRootViewController(animated: true)
					}
				}
		} catch AuthenticationError.loginError {
			setTextForLabel(from: AuthenticationError.loginError)
		} catch {
			fatalError("\(error.localizedDescription)")
		}
		
	}
	
	private func setTextForLabel(from error: LocalizedError) {
		guard let errorLabelView = errorLabelView else { return }
		
		errorLabelView.labelType = .error
		errorLabelView.mainLabel.text = error.errorDescription
		errorLabelView.isHidden = false
	}
}

// MARK: - Dismissable

extension LoginViewController: Dismissable {
	
	var xButton: UIButton {
		return dismissButton
	}
	
	var dismissableViewController: UIViewController {
		return self
	}
	
	var dismissableDelegate: DismissableDelegate {
		get {
			return self.creator
		}
		
		set {
			self.creator = newValue
		}
	}
	
}



