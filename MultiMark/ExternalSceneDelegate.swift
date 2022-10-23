//
//  ExternalSceneDelegate.swift
//  MultiMark
//
//  Created by Felipe Christian Lautenschlager on 23/10/2022.
//

import UIKit

class ExternalSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let previewFontName = "sans-serif"
    let previewFontSize = 200

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if #available(iOS 16.0, *) {
            guard session.role == .windowExternalDisplayNonInteractive else { return }
        } else {
            guard session.configuration.name != AppDelegate.mainSceneConfigurationIdentifier else { return }
        }
        guard let storyboard = session.configuration.storyboard else { return }
        
        guard let previewViewController = storyboard.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController else {
            fatalError("Unable to find PreviewViewController")
        }
        previewViewController.previewFontSize = previewFontSize
        previewViewController.previewFontName = previewFontName
        previewViewController.toolbarHidden = true
        
        ScreenManager.shared.addScreen(window: window!, andViewController: previewViewController)
    }

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

