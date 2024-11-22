//
//  ViewController.swift
//  art run
//
//  Created by 장재석 on 10/10/24.
//
import UIKit

class LoginViewController: UIViewController {

    // UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Art Run"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = UIColor.green
        let blackPart = NSMutableAttributedString(string: "Art ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.green])
        let greenPart = NSAttributedString(string: "Run", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        blackPart.append(greenPart)
        label.attributedText = blackPart
        label.textAlignment = .center
        return label
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember me"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let rememberMeSwitch: UISwitch = {
        let switchControl = UISwitch()
        return switchControl
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    let socialButtonsStackView: UIStackView = {
        let facebookButton = UIButton(type: .system)
        facebookButton.setImage(UIImage(named: "facebook"), for: .normal)
        
        let twitterButton = UIButton(type: .system)
        twitterButton.setImage(UIImage(named: "twitter"), for: .normal)
        
        let googleButton = UIButton(type: .system)
        googleButton.setImage(UIImage(named: "google"), for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [facebookButton, twitterButton, googleButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        return stackView
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have account?"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    func setupLayout() {
        // Add all subviews to the main view
        view.addSubview(titleLabel)
        view.addSubview(loginLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(rememberMeLabel)
        view.addSubview(rememberMeSwitch)
        view.addSubview(loginButton)
        view.addSubview(socialButtonsStackView)
        view.addSubview(signUpLabel)
        view.addSubview(signUpButton)
        
        // Layout Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        rememberMeLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberMeSwitch.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        socialButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for each element
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Login Label
            loginLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Remember me label and switch
            rememberMeLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            rememberMeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            rememberMeSwitch.centerYAnchor.constraint(equalTo: rememberMeLabel.centerYAnchor),
            rememberMeSwitch.leadingAnchor.constraint(equalTo: rememberMeLabel.trailingAnchor, constant: 10),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: rememberMeSwitch.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Social Buttons Stack View
            socialButtonsStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            socialButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Sign up label and button
            signUpLabel.topAnchor.constraint(equalTo: socialButtonsStackView.bottomAnchor, constant: 20),
            signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            signUpButton.centerYAnchor.constraint(equalTo: signUpLabel.centerYAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: signUpLabel.trailingAnchor, constant: 5)
        ])
    }
}
