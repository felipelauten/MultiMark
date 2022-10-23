//
//  PreviewViewController.swift
//  MultiMark
//
//  Created by Felipe Christian Lautenschlager on 23/10/2022.
//

import UIKit
import Down

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var outputView: UITextView!
    
    var text: String = "" {
        didSet {
            let down = Down(markdownString: text)
            let style = "body { font: 200% sans-serif; }"
            let attributedString = try? down.toAttributedString(stylesheet: style)
            updateTextView(with: attributedString)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    fileprivate func updateTextView(with text:NSAttributedString?) {
        guard let attributedString = text else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.outputView.attributedText = attributedString
        }
    }

}
