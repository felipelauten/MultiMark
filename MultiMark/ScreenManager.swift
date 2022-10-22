//
//  ScreenManager.swift
//  MultiMark
//
//  Created by Felipe Christian Lautenschlager on 23/10/2022.
//

import UIKit

class ScreenManager {
    
    // Internal Map
    private var additionalWindows = [UIWindow: UIViewController]()
    
    // Singleton
    static var shared = ScreenManager()
    
    private init() {
        print("Initilizing ScreenManager")
    }
    
    func addScreen(window: UIWindow, andViewController vc: UIViewController) {
        guard !additionalWindows.contains(where: { (key: UIWindow, value: UIViewController) in
            key == window
        }) else {
            print("Trying to add a window that is already managed.")
            return
        }
        
        attachViewController(vc, to: window)
        additionalWindows[window] = vc
    }
    
    func removeScreen(window: UIWindow) {
        guard additionalWindows.contains(where: { (key: UIWindow, value: UIViewController) in
            key == window
        }) else {
            print("Attempting to remove a screen that is not managed.")
            return
        }
        
        detachViewController(from: window)
        additionalWindows[window] = nil
    }
    
    func firstViewController() -> UIViewController? {
        return additionalWindows.first?.value
    }
    
    private func attachViewController(_ vc: UIViewController, to window: UIWindow) {
        window.rootViewController = vc
    }
    
    private func detachViewController(from window: UIWindow) {
        window.rootViewController = nil
    }
}
