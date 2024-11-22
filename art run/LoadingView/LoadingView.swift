import SwiftUI

struct LoadingView: View {
    @State private var isLoading = false
    @State private var isLoadingCompleted = false
    
    var body: some View {
        VStack {
            // 텍스트 표시
            Text("Art Run")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.green)
                .onAppear {
                    // 애니메이션 시작
                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                        isLoading = true
                    }
                    
                    // 3초 후 로딩 완료 처리
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isLoading = false
                        isLoadingCompleted = true
                    }
                }
            
            if isLoadingCompleted {
                // 로딩 완료 후 보여줄 내용
                Text("로딩 완료!")
                    .font(.headline)
                    .foregroundColor(.green)
            } else {
                // 로딩 애니메이션 (회전하는 원)
                Circle()
                    .trim(from: 0.0, to: 0.7)
                    .stroke(Color.green, lineWidth: 5)
                    .frame(width: 50, height: 50)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
