//
//  UIViewControllerExtension.swift
//  GoalPost
//
//  Created by Faisal Babkoor on 8/31/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit

extension UIViewController{
    func presentDetail(_ viewControllerToPresent: UIViewController){
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.duration = 0.3
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.duration = 0.3
        transition.subtype = CATransitionSubtype.fromRight
        guard let presentedViewController = presentedViewController else{return}
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)

        }
    }
    func dismissDetail(){
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.duration = 0.5
        transition.startProgress = Float(0.5)
        //transition.endProgress = Float(3)
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
