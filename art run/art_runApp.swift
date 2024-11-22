import SwiftUI
import Firebase

@main
struct art_runApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @State private var isUserLoggedIn: Bool = false // 로그인 상태 관리

    var body: some Scene {
        WindowGroup {
            if isUserLoggedIn {
                HomeViewControllerRepresentable(isUserLoggedIn: $isUserLoggedIn) // 홈 화면
            } else {
                LoginViewControllerRepresentable(isUserLoggedIn: $isUserLoggedIn) // 로그인 화면
            }
        }
    }
}

struct HomeViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var isUserLoggedIn: Bool

    func makeUIViewController(context: Context) -> HomeViewController {
        let homeVC = HomeViewController()
        homeVC.onLogout = {
            // 로그아웃 처리
            isUserLoggedIn = false
        }
        return homeVC
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
        // 뷰가 업데이트될 때 필요한 작업을 여기서 처리
    }
}

// LoginViewController를 SwiftUI에서 사용하기 위한 래퍼
struct LoginViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var isUserLoggedIn: Bool

    func makeUIViewController(context: Context) -> LoginViewController {
        let loginVC = LoginViewController()
        loginVC.onLoginSuccess = {
            // 로그인 성공 처리
            isUserLoggedIn = true
        }
        return loginVC
    }

    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        // 뷰가 업데이트될 때 필요한 작업을 여기서 처리
    }
}
