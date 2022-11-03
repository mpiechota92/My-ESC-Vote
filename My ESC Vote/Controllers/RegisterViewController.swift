//
//  RegisterViewController.swift
//  My ESC Vote
//
//  Created by Maciej Piechota on 31/10/2022.
//

import UIKit

class RegisterViewController: UIViewController {
	
	private var registrationViewModel = RegistrationFormViewModel()
	
	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmPasswordTextField: UITextField!
	
	@IBOutlet weak var errorLabelView: LabelView!
	
	private var errorLabels = [UILabel?]()
	
	@IBOutlet weak var registerButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registerObserversForTextFields()
		
	}
	
	// Text fields must not be empty for register button to be enabled.
	private func registerObserversForTextFields() {
		
		let notification: (UITextField) -> ((Notification) -> ()) = { textField in
			let closure: (Notification) -> () = { _ in
				let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
				let textIsNotEmpty = textCount > 0
				
				DispatchQueue.main.async { [weak self] in
					self?.registerButton.isEnabled = textIsNotEmpty
				}
			}
			
			return closure
		}
		
		NotificationCenter.default.addObserver(
			forName: UITextField.textDidChangeNotification,
			object: nameTextField,
			queue: OperationQueue.main,
			using: notification(nameTextField)
		)
		
		NotificationCenter.default.addObserver(
			forName: UITextField.textDidChangeNotification,
			object: emailTextField,
			queue: OperationQueue.main,
			using: notification(emailTextField)
		)
		
		NotificationCenter.default.addObserver(
			forName: UITextField.textDidChangeNotification,
			object: passwordTextField,
			queue: OperationQueue.main,
			using: notification(passwordTextField)
		)
		
		NotificationCenter.default.addObserver(
			forName: UITextField.textDidChangeNotification,
			object: confirmPasswordTextField,
			queue: OperationQueue.main,
			using: notification(confirmPasswordTextField)
		)
	}
	
	@IBAction func registerButtonTapped(_ sender: UIButton) {
		
		guard let name = nameTextField.text,
			  let email = emailTextField.text,
			  let password = passwordTextField.text,
			  let confirmPassword = confirmPasswordTextField.text else {
			return
		}
		
		print(name, email, password, confirmPassword, separator: ", ", terminator: ".")
		
		registrationViewModel.registerNewUser(
			name: name,
			email: email,
			password: password,
			confirmPassword: confirmPassword) { [weak self] error in
				if let error = error as? LocalizedError {
					self?.setTextForLabel(from: error)
				} else {
					self?.navigationController?.popToRootViewController(animated: true)
				}
			}
	}
	
	private func setTextForLabel(from error: LocalizedError) {
		guard let errorLabelView = errorLabelView else { return }
		
		errorLabelView.labelType = .error
		errorLabelView.mainLabel.text = error.errorDescription
		errorLabelView.isHidden = false
	}
	
}
