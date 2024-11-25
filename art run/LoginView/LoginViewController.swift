import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

// UIColor extension to support hex color codes
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// UITextField extension to add padding to the left side of text field
extension UITextField {
    func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

class LoginViewController: UIViewController {

    // UI elements
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var signUpButton: UIButton!
    var loginButton: UIButton!
    var onLoginSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        setupUI()
    }

    func setupUI() {
        let screenWidth = UIScreen.main.bounds.width

        // **1. 환영 메시지 추가**
        let welcomeLabel = UILabel(frame: CGRect(x: 20, y: 100, width: screenWidth - 40, height: 50))
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        welcomeLabel.textColor = UIColor.darkGray
        welcomeLabel.text = "Welcome to Art Run!"
        view.addSubview(welcomeLabel)

        // "Art Run" 로고
        let logoLabel = UILabel(frame: CGRect(x: 20, y: 150, width: screenWidth - 40, height: 80))
        logoLabel.textAlignment = .center
        logoLabel.font = UIFont.boldSystemFont(ofSize: 80)
        logoLabel.attributedText = getStyledLogoText()
        view.addSubview(logoLabel)

        // 이메일 입력 필드
        emailTextField = createTextField(placeholder: "Email", y: 300)
        view.addSubview(emailTextField)

        // 비밀번호 입력 필드
        passwordTextField = createTextField(placeholder: "Password", y: 370)
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)

        // 로그인 버튼
        loginButton = UIButton(frame: CGRect(x: 40, y: 470, width: screenWidth - 80, height: 50))
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(hex: "33CD5F")
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 10
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        view.addSubview(loginButton)

        // 회원가입 버튼
        signUpButton = UIButton(frame: CGRect(x: 40, y: 540, width: screenWidth - 80, height: 50))
        signUpButton.setTitle("Don't have an account? Sign up", for: .normal)
        signUpButton.setTitleColor(UIColor(hex: "888888"), for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signUpButton.addTarget(self, action: #selector(navigateToSignUp), for: .touchUpInside)
        view.addSubview(signUpButton)

        // **3. 소셜 로그인 버튼 추가**
        let googleButton = UIButton(type: .system)
        googleButton.setImage(UIImage(systemName: "globe"), for: .normal) // Google 아이콘 (예시용으로 globe 사용)
        
        let facebookButton = UIButton(type: .system)
        facebookButton.setImage(UIImage(systemName: "f.square"), for: .normal) // Facebook 아이콘 (예시용으로 f.square 사용)
        
        let socialStackView = UIStackView(arrangedSubviews: [googleButton, facebookButton])
        socialStackView.axis = .horizontal
        socialStackView.spacing = 20
        socialStackView.alignment = .center
        socialStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(socialStackView)

        // 소셜 버튼 제약 조건 설정
        NSLayoutConstraint.activate([
            socialStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            socialStackView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            googleButton.widthAnchor.constraint(equalToConstant: 40),
            googleButton.heightAnchor.constraint(equalToConstant: 40),
            facebookButton.widthAnchor.constraint(equalToConstant: 40),
            facebookButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc func buttonHighlighted() {
        loginButton.backgroundColor = UIColor(hex: "28A745") // 터치 시 더 어두운 색으로 변경
    }

    @objc func buttonReleased() {
        loginButton.backgroundColor = UIColor(hex: "33CD5F") // 기본 색으로 복원
    }

    func createTextField(placeholder: String, y: CGFloat) -> UITextField {
        let textField = UITextField(frame: CGRect(x: 40, y: y, width: UIScreen.main.bounds.width - 80, height: 50))
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.setLeftPadding(10) // Add padding
        return textField
    }

    func getStyledLogoText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Art Run")
        attributedText.addAttribute(.foregroundColor, value: UIColor(hex: "33CD5F"), range: NSRange(location: 0, length: 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 1, length: 3))
        attributedText.addAttribute(.foregroundColor, value: UIColor(hex: "33CD5F"), range: NSRange(location: 4, length: 1))
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 5, length: 2))
        return attributedText
    }

    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.showLoginError(message: error.localizedDescription)
                return
            }

            // 로그인 성공 시 HomeViewController로 전환
            self?.navigateToHome()
        }
    }

    func navigateToHome() {
        let homeVC = HomeViewController()
        
        // 네비게이션 컨트롤러가 있으면 푸시하고 없으면 모달로 띄우기
        if let navigationController = self.navigationController {
            navigationController.pushViewController(homeVC, animated: true)
        } else {
            let navController = UINavigationController(rootViewController: homeVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }

    func showLoginError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc func navigateToSignUp() {
        print("Sign up 버튼이 눌렸습니다") // 디버깅용 프린트
        let signUpVC = SignUpViewController() // SignUpViewController를 인스턴스화
        
        // 네비게이션 컨트롤러가 없는 경우 새로 네비게이션 컨트롤러를 만들도록 수정
        if let navigationController = self.navigationController {
            navigationController.pushViewController(signUpVC, animated: true)
        } else {
            // 네비게이션 컨트롤러가 없으면 새로 생성하고 화면 전환
            let navController = UINavigationController(rootViewController: signUpVC)
            navController.modalPresentationStyle = .fullScreen // Full-screen modal presentation
            self.present(navController, animated: true, completion: nil)
        }
    }
}
