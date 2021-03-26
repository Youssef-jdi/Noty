//
//  ToastManager.swift
//  Noty
//
//  Created by Youssef Jdidi on 16/2/2021.
//

import UIKit

protocol ToastManagerProtocol {
    func showToast(for toastCase: Toast.ToastCases)
}

class ToastManager: ToastManagerProtocol {
    private var toastView: Toast?

    func showToast(for toastCase: Toast.ToastCases) {
        animate(toastCase: toastCase)
    }

    private func addSubview(toastCase: Toast.ToastCases) {
        self.toastView = Toast()
        toastView?.configureToast(with: toastCase)
        let multiplier = getMultiplier(for: toastCase)
        guard let target = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        if let size = toastView?.systemLayoutSizeFitting(CGSize(width: target.frame.width * multiplier,
                                                                height: UIView.layoutFittingCompressedSize.height),
                                                         withHorizontalFittingPriority: .required,
                                                         verticalFittingPriority: .fittingSizeLevel) {
            toastView?.frame.size = size
            toastView?.center = CGPoint(x: target.center.x,
                                        y: target.frame.height + ((size.height / 2) * multiplier))

            target.addSubview(toastView!)
        }
    }

    private func animate(toastCase: Toast.ToastCases) {
        addSubview(toastCase: toastCase)
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            Console.log(type: .message, "Showing toast for case: \(toastCase)")
            self.toastView?.transform = CGAffineTransform(
                translationX: 0,
                y: -self.toastView!.frame.height)
            DispatchQueue.main.asyncAfter(deadline: .now() + self.getDuration(for: toastCase)) { [weak self] in
                guard let self = self else { return }
                UIView.animate(
                    withDuration: 0.3,
                    animations: {
                        Console.log(type: .message, "Hiding toast for case: \(toastCase)")
                        self.toastView?.transform = .identity
                }) { _ in
                    Console.log(type: .message, "Removed toast for case: \(toastCase)")
                    self.toastView?.removeFromSuperview()
                }
            }
        }
    }

    private func getMultiplier(for toastCase: Toast.ToastCases) -> CGFloat {
        switch toastCase {
        case .cantSaveNote,
             .noteSaved:
            return 0.5
        default:
            return 0.5
        }
    }

    private func getDuration(for toastCase: Toast.ToastCases) -> Double {
        switch toastCase {
        case .emptyTitle:
            return 0.6
        case .noteSaved,
             .cantSaveNote:
            return 1
        default:
            return 2.0
        }
    }
}
