//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Faisal Babkoor on 8/31/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        goalTextView.delegate = self
        addDismissKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(clear(_:)), name: NSNotification.Name(rawValue: "done"), object: nil)
    }
    
    @objc func clear(_ notification: Notification){
        goalTextView.text = ""
        dismissDetail()
    }
    
    func addDismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = GoalType.shortTerm
        selecteButton()
    }
    
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = GoalType.longTerm
        selecteButton()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != "What is your goal?"{
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {return}
            finishGoalVC.goal = goalTextView.text
            finishGoalVC.goalType = goalType
            presentDetail(finishGoalVC)
            
            
            
        }
    }
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    fileprivate func selecteButton(){
        switch goalType {
        case .shortTerm:
            shortTermBtn.setSelected()
            longTermBtn.setDeselected()
        case .longTerm:
            longTermBtn.setSelected()
            shortTermBtn.setDeselected()
        }
    }
}

extension CreateGoalVC: UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if goalTextView.text == "What is your goal?" {
            goalTextView.text = ""
            return true
        }else{
            return true
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if goalTextView.text == ""{
            goalTextView.text = "What is your goal?"
            return true
        }else{
            return true
        }
    }
}
