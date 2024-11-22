import SwiftUI

// LoginViewController를 SwiftUI에서 사용할 수 있도록 감싸는 Wrapper
struct LoginViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isUserLoggedIn: Bool

    func makeUIViewController(context: Context) -> LoginViewController {
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = {
            // 로그인 성공 후 상태 업데이트
            self.isUserLoggedIn = true
        }
        return loginVC
    }

    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        // UI 업데이트가 필요하면 처리
    }
}
