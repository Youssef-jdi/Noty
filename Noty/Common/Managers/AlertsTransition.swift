//
//  AlertsTransition.swift
//  Noty
//
//  Created by Youssef Jdidi on 20/3/2021.
//

import UIKit

class AlertsTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let duration = 0.35
    var isPresenting = true

    var value: CGFloat = 500

    func setValue(_ value: CGFloat) {
        self.value = value
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.viewController(forKey: .to)?.view,
            let fromView = transitionContext.viewController(forKey: .from)?.view else { return }

        let value: CGFloat = isPresenting ? self.value : -self.value

        containerView.addSubview(toView)
        containerView.addSubview(fromView)

        toView.transform = CGAffineTransform.init(translationX: value,
                                                  y: 0)
        UIView.animate(
            withDuration: duration,
            animations: {
                toView.transform = .identity
                fromView.transform = CGAffineTransform.init(translationX: -value,
                                                            y: 0)
        },
            completion: { _ in
                transitionContext.completeTransition(true)
        })
    }
}
