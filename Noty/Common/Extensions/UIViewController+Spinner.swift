//
//  UIViewController+Spinner.swift
//  Noty
//
//  Created by Youssef Jdidi on 16/2/2021.
//

import UIKit

extension UIViewController {

    private var overlayViewTag: Int {
        return 37101
    }

    /// Shows a UI blocking spinner.
    func showSpinner() {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        guard keyWindow.viewWithTag(overlayViewTag) == nil else {
            return
        }
        let overlayView = SpinnerOverlayView(frame: keyWindow.frame)
        overlayView.tag = overlayViewTag
        keyWindow.addSubview(overlayView)
        UIView.animate(withDuration: 0.2) { overlayView.alpha = 1 }
    }

    /// Hides the current spinner if needed.
    func hideSpinner() {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        guard let overlayView = keyWindow.viewWithTag(overlayViewTag) else {
            return
        }
        UIView.animate(
            withDuration: 0.2,
            animations: {
                overlayView.alpha = 0
         },
            completion: { _ in overlayView.removeFromSuperview() })
    }
}

class SpinnerOverlayView: UIView {

    private lazy var spinnerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        return spinner
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        alpha = 0
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        spinnerView.center = center
        addSubview(spinnerView)
        spinnerView.startAnimating()
    }
}
