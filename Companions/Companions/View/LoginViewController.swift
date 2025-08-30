//
//  ViewController.swift
//  Companions
//
//  Created by Tiana Patti on 11/16/22.
//

import UIKit
import LocalAuthentication
import AuthenticationServices

final class LoginViewController: UIViewController {
	
	private var viewModel: LoginViewModelProtocol
	private var snowFlakes = SnowFlakeManager()
	
	// MARK: - UI Elements
	
	private lazy var labelView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: K.logo)
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	private lazy var loginTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Username"
		tf.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		tf.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.85)
		tf.layer.cornerRadius = 12
		tf.autocapitalizationType = .none
		tf.autocorrectionType = .no
		tf.returnKeyType = .next
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.setLeftPaddingPoints(12)
		tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
		return tf
	}()
	
	private lazy var passwordTextField: UITextField = {
		let tf = UITextField()
		tf.placeholder = "Password"
		tf.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		tf.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.85)
		tf.layer.cornerRadius = 12
		tf.isSecureTextEntry = true
		tf.autocapitalizationType = .none
		tf.autocorrectionType = .no
		tf.returnKeyType = .done
		tf.translatesAutoresizingMaskIntoConstraints = false
		tf.setLeftPaddingPoints(12)
		tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
		return tf
	}()
	
	private lazy var loginButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = .systemPurple
		button.setTitle(K.loginButtonTitle, for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		button.layer.cornerRadius = 12
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
		button.heightAnchor.constraint(equalToConstant: 44).isActive = true
		return button
	}()
	
	private lazy var noConnectionImage: UIImageView = {
		let imageView = UIImageView()
		let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .regular)
		imageView.image = UIImage(systemName: "wifi.exclamationmark", withConfiguration: config)
		imageView.tintColor = .systemRed
		imageView.isHidden = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	private lazy var noConnectionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .title2)
		label.textColor = .systemRed
		label.textAlignment = .center
		label.text = "No Internet Connection"
		label.numberOfLines = 0
		label.isHidden = true
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private lazy var inputStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [loginTextField, passwordTextField, loginButton])
		stack.axis = .vertical
		stack.spacing = 16
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// MARK: - Lifecycle
	
	init(_ viewModel: LoginViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		
		self.viewModel.onUpdate = { [weak self] in
			DispatchQueue.main.async {
				self?.updateView()
			}
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		callToViewModelForUpdate()
	}
	
	// MARK: - Setup
	
	private func setupView() {
		if let bgImage = UIImage(named: K.background) {
			view.backgroundColor = UIColor(patternImage: bgImage)
		} else {
			view.backgroundColor = .systemBackground
		}
		
		snowFlakes.injectSnowLayer(into: view)
		
		view.addSubview(containerView)
		containerView.addSubview(labelView)
		containerView.addSubview(inputStackView)
		view.addSubview(noConnectionImage)
		view.addSubview(noConnectionLabel)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			// Container View
			containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			
			// Logo
			labelView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
			labelView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			labelView.heightAnchor.constraint(equalToConstant: 60),
			labelView.widthAnchor.constraint(equalToConstant: 80),
			
			// Input Stack
			inputStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			inputStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
			inputStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
			
			// No Connection UI
			noConnectionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			noConnectionImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
			
			noConnectionLabel.topAnchor.constraint(equalTo: noConnectionImage.bottomAnchor, constant: 16),
			noConnectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
			noConnectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
		])
	}
	
	// MARK: - Actions
	
	@objc private func loginButtonPressed() {
		view.endEditing(true)
		callToViewModelForUpdate()
		
		if viewModel.checkConnection {
			let searchVC = SearchViewController()
			navigationController?.pushViewController(searchVC, animated: true)
			print("Login Success")
			print(UserDefaults.standard.string(forKey: "token") ?? "")
			print(UserDefaults.standard.string(forKey: "tokenType") ?? "")
		}
	}
	
	// MARK: - ViewModel Interaction
	
	private func callToViewModelForUpdate() {
		if !viewModel.checkConnection {
			showNoConnectionUI()
			return
		}
		hideNoConnectionUI()
		viewModel.fetch()
	}
	
	// MARK: - UI Updates
	
	private func updateView() {
		// Update view based on viewModel state
	}
	
	private func showNoConnectionUI() {
		UIView.animate(withDuration: 0.3) {
			self.view.backgroundColor = .systemBackground
			self.containerView.alpha = 0
			self.noConnectionImage.isHidden = false
			self.noConnectionLabel.isHidden = false
			self.noConnectionImage.alpha = 1
			self.noConnectionLabel.alpha = 1
		}
	}
	
	private func hideNoConnectionUI() {
		UIView.animate(withDuration: 0.3) {
			self.containerView.alpha = 1
			self.noConnectionImage.alpha = 0
			self.noConnectionLabel.alpha = 0
		} completion: { _ in
			self.noConnectionImage.isHidden = true
			self.noConnectionLabel.isHidden = true
		}
	}
}

private extension UITextField {
	func setLeftPaddingPoints(_ amount: CGFloat) {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
		leftView = paddingView
		leftViewMode = .always
	}
}

