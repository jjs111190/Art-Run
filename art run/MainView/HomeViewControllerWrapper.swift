import SwiftUI

struct HomeViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isUserLoggedIn: Bool

    func makeUIViewController(context: Context) -> HomeViewController {
        let viewController = HomeViewController()
        // 필요한 설정을 여기서 진행
        return viewController
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
        // 상태 업데이트가 필요하면 여기서 진행
    }
}
