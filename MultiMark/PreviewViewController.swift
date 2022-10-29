//
//  PreviewViewController.swift
//  MultiMark
//
//  Created by Felipe Christian Lautenschlager on 23/10/2022.
//

import UIKit
import Down

class PreviewViewController: UIViewController {
    
    @IBOutlet private weak var toolbar: UIToolbar!
    @IBOutlet private weak var outputView: UITextView!
    
    var previewFontName = "sans-serif"
    var previewFontSize = 100
    
    @IBInspectable var toolbarHidden: Bool = true
    
    var text: String = "" {
        didSet {
            refreshPreview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setToolbarHidden(toolbarHidden)
    }
    
    fileprivate func setToolbarHidden(_ value: Bool) {
        toolbar.isHidden = value
    }
    
    fileprivate func refreshPreview() {
        let down = Down(markdownString: text)
        let style = "body { font: \(previewFontSize)% \(previewFontName); font-color: \(UIColor.label)}"
        let attributedString = try? down.toAttributedString(stylesheet: style)
        
        updateTextView(with: attributedString)
    }
    
    @IBAction func zoomChanged(_ sender: UISlider) {
        previewFontSize = Int(sender.value)
        refreshPreview()
    }
    
    fileprivate func updateTextView(with text:NSAttributedString?) {
        guard let attributedString = text else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.outputView.attributedText = attributedString
        }
    }

}
