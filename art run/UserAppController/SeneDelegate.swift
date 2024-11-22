//
//  SeneDelegate.swift
//  art run
//
//  Created by 장재석 on 11/20/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1. UIWindow 설정
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // 2. SignUpViewController를 네비게이션 컨트롤러에 넣어서 루트 뷰 컨트롤러로 설정
        let signUpVC = SignUpViewController()
        let navController = UINavigationController(rootViewController: signUpVC)
        window?.rootViewController = navController
        
        // 3. 화면 표시
        window?.makeKeyAndVisible()
    }

    // 다른 필요한 메서드들...
}
