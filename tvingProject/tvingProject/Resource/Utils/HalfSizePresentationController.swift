//
//  HalfSizePresentationController.swift
//  tvingProject
//
//  Created by 이명진 on 4/16/24.
//

import UIKit

import SnapKit
import Then

final class HalfSizePresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }
        let height = containerView.bounds.height / 2
        let y = containerView.bounds.height - height
        
        return CGRect(x: 0, y: y, width: containerView.bounds.width, height: height)
    }
    
    // MARK: - UIComponents
    
    private lazy var dimmingView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        $0.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        $0.addGestureRecognizer(tap)
    }
    
    // MARK: - Methods
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.insertSubview(dimmingView, at: 0)
        
        dimmingView.snp.makeConstraints { make in
            make.edges.equalTo(containerView!)
        }
        
        presentedView?.layer.cornerRadius = 20
        presentedView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1
            })
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0
            }) { _ in
                self.dimmingView.removeFromSuperview()
            }
        }
    }
    
    @objc
    private func dismissController() {
        presentedViewController.dismiss(animated: true)
    }
    
}
