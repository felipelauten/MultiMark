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
        textView.delegate = self
        
        NotificationCenter.default.addObserver(forName: ScreenManager.ScreenConnected,
                                               object: nil,
                                               queue: nil) { [weak self] notification in
            guard let self = self else { return }
            guard let preview = notification.object as? PreviewViewController else { return }
            
            self.updateText(on: preview)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // Updates external display view controller (if exists)
        if let preview = ScreenManager.shared.firstViewController() as? PreviewViewController {
            updateText(on: preview)
        }
        
        // Updates Split Screen secondary view controller
        if let secondaryNav = splitViewController?.viewControllers.last as? UINavigationController,
           let splitPreview = secondaryNav.topViewController as? PreviewViewController {
            updateText(on: splitPreview)
        }
    }

    func updateText(on viewController: PreviewViewController) {
        viewController.text = textView.text
    }

}

