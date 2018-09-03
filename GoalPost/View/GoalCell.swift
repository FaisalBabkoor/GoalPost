//
//  GoalCell.swift
//  GoalPost
//
//  Created by Faisal Babkoor on 8/31/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    
    func configureCell(goal: Goal) {
        self.goalDescriptionLbl.text = "Goal: \(goal.goalDescription!)"
        self.goalTypeLbl.text = "Type: \(goal.goalType!)"
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        if goal.goalProgress == goal.goalCompletionValue{
            completionView.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.completionView.transform = CGAffineTransform(translationX: 150, y: 150)
            }) { (success) in
                if success{
                    self.completionView.transform = .identity
                }
            }
        }else{
            completionView.isHidden = true
        }
    }

}
