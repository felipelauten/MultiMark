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
        
        // Hides the preview button for iPads
        let device = UIDevice.current
        if device.userInterfaceIdiom == .pad {
            self.navigationItem.setRightBarButton(nil, animated: false)
        }
        
        NotificationCenter.default.addObserver(forName: ScreenManager.ScreenConnected,
                                               object: nil,
                                               queue: nil) { [weak self] notification in
            guard let self = self else { return }
            guard let preview = notification.object as? PreviewViewController else { return }
            
            self.updateText(on: preview)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController, let previewViewController = navController.topViewController as? PreviewViewController else {
            fatalError("Could not get PreviewViewController from segue")
        }
        
        updateText(on: previewViewController)
    }
}

