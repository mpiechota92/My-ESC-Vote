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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		tabBarController?.tabBar.isHidden = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registerObserversForTextFields()
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		tabBarController?.tabBar.isHidden = false
	}
	
	// Text fields must not be empty for register button to be enabled.
	private func registerObserversForTextFields() {
		
		let notificationGenerator: NotificationGenerator<UITextField> = { textField in
			let closure: (Notification) -> () = { _ in
				let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
				let textIsNotEmpty = textCount > 0
				
				DispatchQueue.main.async { [weak self] in
					self?.registerButton.isEnabled = textIsNotEmpty
				}
			}
			
			return closure
		}
		
		self.addObserversToSubviews(in: self.view, with: notificationGenerator, forName: UITextField.textDidChangeNotification)
		
	}
	
	@IBAction func registerButtonTapped(_ sender: UIButton) {
		
		guard let name = nameTextField.text,
			  let email = emailTextField.text,
			  let password = passwordTextField.text,
			  let confirmPassword = confirmPasswordTextField.text else {
			return
		}
		
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