//
//  SceneDelegate.swift
//  MultiMark
//
//  Created by Felipe Christian Lautenschlager on 22/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if #available(iOS 16.0, *) {
            guard session.role == .windowApplication else { return }
        } else {
            guard session.configuration.name == AppDelegate.mainSceneConfigurationIdentifier else { return }
        }
        // Sets split screen preferred properties
        if let split = window?.rootViewController as? UISplitViewController {
            split.delegate = self
            split.maximumPrimaryColumnWidth = .greatestFiniteMagnitude
            split.preferredPrimaryColumnWidthFraction = 0.5
        }
    }
    
    // This makes the secondary view controller to always be visible on large iPhones
//    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
//        return true
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        ScreenManager.shared.removeScreen(window: window!)
        print("ℹ️ Scene \(scene.session.configuration.name ?? "Unknow") disconnected")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("ℹ️ Scene \(scene.session.configuration.name ?? "Unknow") became active")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("ℹ️ Scene \(scene.session.configuration.name ?? "Unknow") will resign active")
    }

}
