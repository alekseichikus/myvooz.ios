//
//  ModalView.swift
//  USATU6
//
//  Created by aleksei on 21.10.19.
//  Copyright © 2019 aleksei. All rights reserved.
//

import UIKit

final class InteractiveModalPresentationController: UIPresentationController {
    
    var presentedYOffset: CGFloat = 0
    private var direction: CGFloat = 0
    private var state: ModalScaleState = .interaction
    private lazy var dimmingView: UIView! = {
        guard let container = containerView else { return nil }
        
        let view = UIView(frame: container.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didTap(tap:)))
        )
        
        return view
    }()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedViewController.view.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: #selector(didPan(pan:)))
        )
    }
    
    @objc func didPan(pan: UIPanGestureRecognizer) {
    }
    
    @objc func didTap(tap: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    func changeScale(to state: ModalScaleState) {
        guard let presented = presentedView else { return }
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            guard let `self` = self else { return }
            
            presented.frame = self.frameOfPresentedViewInContainerView
            
            }, completion: { (isFinished) in
                self.state = state
        })
    }
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return .zero }
        
        return CGRect(x: 0, y: self.presentedYOffset, width: container.bounds.width, height: container.bounds.height - self.presentedYOffset)
    }
    
    override func presentationTransitionWillBegin() {
        guard let container = containerView,
            let coordinator = presentingViewController.transitionCoordinator else { return }
        
        dimmingView.alpha = 0
        container.addSubview(dimmingView)
        dimmingView.addSubview(presentedViewController.view)
        
        coordinator.animate(alongsideTransition: { [weak self] context in
            guard let `self` = self else { return }
            
            self.dimmingView.alpha = 1
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        
        coordinator.animate(alongsideTransition: { [weak self] (context) -> Void in
            guard let `self` = self else { return }
            
            self.dimmingView.alpha = 0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
}
final class InteractiveModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var interactiveDismiss = true
    var presentedYOffset:CGFloat = 130
    init(from presented: UIViewController, to presenting: UIViewController) {
        super.init()
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        var pres = InteractiveModalPresentationController(presentedViewController: presented, presenting: presenting)
        pres.presentedYOffset = presentedYOffset
        return pres
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
}
