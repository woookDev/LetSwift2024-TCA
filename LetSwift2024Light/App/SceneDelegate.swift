//
//  SceneDelegate.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    
    var window: UIWindow?
    
    // MARK: - UIWindowSceneDelegate

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        window.rootViewController = setupMainViewController()
        window.makeKeyAndVisible()
    }
}

// MARK: - Private Methods

extension SceneDelegate {
    private func setupMainViewController() -> UINavigationController {
        let repo = MainRepositoryImpl(
            jsonDecoder: JSONDecoder()
        )
        
        let mainViewController = MainViewController(store: .init(initialState: MainReducer.State(), reducer: {
            MainReducer()
                .dependency(\.mainClient, .init(fetchTrackInfo: repo.fetchSessionsInfo))
        }))
        
        let navigationController = UINavigationController(
            rootViewController: mainViewController
        )
        
        return navigationController
    }
}
