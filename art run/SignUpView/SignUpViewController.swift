import UIKit
import FirebaseAuth  // Firebase Auth 모듈 추가

class SignUpViewController: UIViewController {
    private let usernameField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let policyCheckBox = UISwitch()
    private let signUpButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        updateSignUpButtonState()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        
        // Left Bar Button Item (Back Button)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBackButton))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func handleBackButton() {
        // Check if the navigation stack has a view controller to pop back to
        if let navigationController = navigationController {
            // Try to find the LoginViewController in the navigation stack
            if let loginViewController = navigationController.viewControllers.first(where: { $0 is LoginViewController }) {
                navigationController.popToViewController(loginViewController, animated: true)
            } else {
                // If not found, instantiate it programmatically and push it onto the navigation stack
                let loginViewController = LoginViewController()  // Make sure to instantiate LoginViewController appropriately
                navigationController.pushViewController(loginViewController, animated: true)
            }
        }
    }
    
    private func setupUI() {
        // Welcome Label
        let welcomeLabel = UILabel()
        let attributedText = NSMutableAttributedString(string: "Welcome")
        attributedText.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: NSRange(location: 0, length: 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 1, length: 6))
        welcomeLabel.attributedText = attributedText
        welcomeLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        // Sign Up Label
        let signUpLabel = UILabel()
        signUpLabel.text = "Sign up"
        signUpLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        signUpLabel.textColor = .black
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpLabel)
        
        // Username Field
        setupTextField(usernameField, placeholder: "Username")
        
        // Email Field
        setupTextField(emailField, placeholder: "Email")
        
        // Password Field
        setupTextField(passwordField, placeholder: "Password", isSecure: true)
        
        // Privacy Policy
        let policyStack = UIStackView()
        policyStack.axis = .horizontal
        policyStack.spacing = 8
        policyStack.alignment = .center
        policyStack.translatesAutoresizingMaskIntoConstraints = false
        
        let policyLabel = UILabel()
        policyLabel.text = "I agree to the terms"
        policyLabel.font = UIFont.systemFont(ofSize: 14)
        policyLabel.textColor = .darkGray
        policyStack.addArrangedSubview(policyCheckBox)
        policyStack.addArrangedSubview(policyLabel)
        policyCheckBox.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        view.addSubview(policyStack)
        
        // Sign Up Button
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = UIColor.systemGreen
        signUpButton.layer.cornerRadius = 8
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.5
        view.addSubview(signUpButton)
        
        // Layout Constraints
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30),
            signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            usernameField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            usernameField.heightAnchor.constraint(equalToConstant: 44),
            
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 44),
            
            policyStack.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            policyStack.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: policyStack.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String, isSecure: Bool = false) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        view.addSubview(textField)
    }
    
    @objc private func textFieldsDidChange() {
        updateSignUpButtonState()
    }
    
    @objc private func switchDidChange() {
        updateSignUpButtonState()
    }
    
    private func updateSignUpButtonState() {
        let isFormValid = isFormCompleted()
        signUpButton.isEnabled = isFormValid
        signUpButton.alpha = isFormValid ? 1.0 : 0.5
    }
    
    private func isFormCompleted() -> Bool {
        guard
            let username = usernameField.text, !username.isEmpty,
            let email = emailField.text, isValidEmail(email),
            let password = passwordField.text, isValidPassword(password)
        else { return false }
        return policyCheckBox.isOn
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    @objc private func handleSignUp() {
        guard
            let email = emailField.text, isValidEmail(email),
            let password = passwordField.text, isValidPassword(password)
        else {
            let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid email and a password with at least 6 characters.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Firebase 가입 처리
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
                return
            }
            
            // 가입 성공 후 LoginViewController로 이동
            if let navigationController = self?.navigationController {
                // LoginViewController가 네비게이션 스택에 있으면 해당 화면으로 이동
                if let loginViewController = navigationController.viewControllers.first(where: { $0 is LoginViewController }) {
                    navigationController.popToViewController(loginViewController, animated: true)
                } else {
                    // LoginViewController가 네비게이션 스택에 없으면, 새로 생성해서 푸시
                    let loginViewController = LoginViewController() // 또는 storyBoard로 초기화
                    navigationController.pushViewController(loginViewController, animated: true)
                }
            }
        }
    }
}
