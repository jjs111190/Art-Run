import SwiftUI

struct ContentView: View {
    @State private var isUserLoggedIn: Bool = false // 로그인 상태 변수

    var body: some View {
        LoginViewControllerWrapper(isUserLoggedIn: $isUserLoggedIn) // Binding<Bool>으로 전달
            .edgesIgnoringSafeArea(.all) // 전체 화면 사용
    }
}

#Preview {
    ContentView() // Preview에서 ContentView 확인
}
