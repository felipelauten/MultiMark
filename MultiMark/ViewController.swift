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
        guard let preview = ScreenManager.shared.firstViewController() as? PreviewViewController else { return }
        updateText(on: preview)
    }

    func updateText(on viewController: PreviewViewController) {
        viewController.text = textView.text
    }

}

