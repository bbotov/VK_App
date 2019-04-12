//
//  CustomTransition.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 03.12.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit

//ПЕРЕХОД МЕЖДУ ЭКРАНАМИ ИЗ МЕТОДИЧКИ
final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.75,
                                                       animations: {
                                                        let translation = CGAffineTransform(translationX: -200, y: 0)
                                                        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                                                        source.view.transform = translation.concatenating(scale)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.2,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                                                        let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                                        destination.view.transform = translation.concatenating(scale)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        destination.view.transform = .identity
                                    })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)

        destination.view.frame = source.view.frame

        let translation = CGAffineTransform(translationX: -200, y: 0)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        destination.view.transform = translation.concatenating(scale)

        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 0)
                                                        let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                                        source.view.transform = translation.concatenating(scale)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.4,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        source.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                       relativeDuration: 0.75,
                                                       animations: {
                                                        destination.view.transform = .identity
                                    })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            if operation == .push {
                self.interactiveTransition.viewController = toVC
                return CustomPushAnimator()
            } else if operation == .pop {
                if navigationController.viewControllers.first != toVC {
                    self.interactiveTransition.viewController = toVC
                }
                return CustomPopAnimator()
            }
            return nil
    }

    let interactiveTransition = CustomInteractiveTransition()

    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactiveTransition.hasStarted ? interactiveTransition : nil
    }



}

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self,
                                                              action: #selector(handleScreenEdgeGesture(_:)))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }

    var hasStarted: Bool = false

    var shouldFinish: Bool = false


    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {

        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / (recognizer.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))

            self.shouldFinish = progress > 0.33

            self.update(progress)
        case .ended:
            self.hasStarted = false
            self.shouldFinish ? self.finish() : self.cancel()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default: return
        }
    }
}

//3D ПЕРЕХОД МЕЖДУ ЭКРАНАМИ
//final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
//
//    var reverse: Bool = false
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.6
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let containerView = transitionContext.containerView
//        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
//        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
//        let toView = toViewController.view
//        let fromView = fromViewController.view
//        let direction: CGFloat = reverse ? -1 : 1
//        let const: CGFloat = -0.005
//        toView!.layer.anchorPoint = CGPoint(x: direction == 1 ? 0 : 1, y: 0.5)
//        fromView!.layer.anchorPoint = CGPoint(x: direction == 1 ? 1 : 0, y: 0.5)
//        var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
//        var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(Double.pi / 2), 0.0, 1.0, 0.0)
//        viewFromTransform.m34 = const
//        viewToTransform.m34 = const
//        containerView.transform = CGAffineTransform(translationX: direction * containerView.frame.size.width / 2.0, y: 0)
//        toView!.layer.transform = viewToTransform
//        containerView.addSubview(toView!)
//        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
//                                delay: 0,
//                                options: .calculationModePaced,
//                                animations: {
//                                    containerView.transform = CGAffineTransform(translationX: -direction * containerView.frame.size.width / 2.0, y: 0)
//            fromView!.layer.transform = viewFromTransform
//            toView!.layer.transform = CATransform3DIdentity
//        }, completion: {
//            finished in
//            containerView.transform = CGAffineTransform.identity
//            fromView!.layer.transform = CATransform3DIdentity
//            toView!.layer.transform = CATransform3DIdentity
//            fromView!.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//            toView!.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//
//            if (transitionContext.transitionWasCancelled) {
//                toView!.removeFromSuperview()
//            } else {
//                fromView!.removeFromSuperview()
//            }
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
//    }
//}
//
//
//class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        delegate = self
//    }
//
//    let  customNavigationAnimationController = CustomPushAnimator()
//
//    func navigationController(_ navigationController: UINavigationController,
//                              animationControllerFor operation: UINavigationController.Operation,
//                              from fromVC: UIViewController,
//                              to toVC: UIViewController)
//        -> UIViewControllerAnimatedTransitioning? {
//        customNavigationAnimationController.reverse = operation == .pop
//        return customNavigationAnimationController
//    }
//}

