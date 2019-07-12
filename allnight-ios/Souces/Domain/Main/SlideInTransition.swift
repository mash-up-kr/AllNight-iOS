//
//  SlideInTransition.swift
//  allnight-ios
//
//  Created by 공지원 on 12/07/2019.
//  Copyright © 2019 kanghoon. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    //side menu view controller가 present 되어있는지, 아닌지에 대한 flag
    var isPresenting = false
    private let statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    //transition이 몇초에 걸쳐서 진행되게 할것인지
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    @objc func handleTap() {
        print("handle tap")
    }
    
    //transitionContext: 화면 전환과 관련된 정보를 담고있는 객체
    //context의 container가 View, VC에 대한 정보를 담고있음
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.64
        let finalHeight = toViewController.view.bounds.height - statusBarHeight
        
        if isPresenting {
            //add side menu view controller to container
            containerView.addSubview(toViewController.view)
            
            //Init frame off the screen
            toViewController.view.frame = CGRect(x: fromViewController.view.bounds.width, y: statusBarHeight, width: finalWidth, height: finalHeight)
        }
        
        //animate on screen
        let transform = {
            toViewController.view.transform = CGAffineTransform(translationX: -finalWidth, y: 0)
            fromViewController.view.layer.opacity = 0.5
        }
        
        //animate back off screen
        let identity = {
            fromViewController.view.transform = .identity
            toViewController.view.layer.opacity = 1.0
        }
        
        //animation of the transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
        
    }
}
