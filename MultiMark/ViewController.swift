//
//  ViewController.swift
//  MultiMark
//
//  Created by Felipe Christian Lautenschlager on 22/10/2022.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(forName: UIScreen.didConnectNotification, object: nil, queue: nil) { [weak self] notification in
//            guard let self = self else { return }
//
//            guard let newScreen = notification.object as? UIScreen else { return }
//            let screenDimentions = newScreen.bounds
//
//            let newWindow = UIWindow(frame: screenDimentions)
//            newWindow.screen = newScreen
//
//            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController else {
//                fatalError("Unable to find PreviewViewController")
//            }
//
//            newWindow.rootViewController = vc
//            newWindow.isHidden = false
//            self.additionalWindows.append(newWindow)
//        }
        
        textView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let preview = ScreenManager.shared.firstViewController() as? PreviewViewController else { return }
        preview.text = textView.text
    }


}

