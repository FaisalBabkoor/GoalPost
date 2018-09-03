//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Faisal Babkoor on 9/1/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit
import CoreData
class FinishGoalVC: UIViewController {
    
    var goal: String!
    var goalType: GoalType!
    
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createGoalBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.textColor = #colorLiteral(red: 0.4922404289, green: 0.7722371817, blue: 0.4631441236, alpha: 1)
        createGoalBtn.bindToKeyboard()
        addDismissKeyboard()
    }
    
    func addDismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        if pointsTextField.text != "" && pointsTextField.text != "\(0)"{
            if let _ = storyboard?.instantiateViewController(withIdentifier: "GoalVC") as? GoalVC{
                save { (success) in
                    if success{
                        dismissDetail()
                        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "done"), object: nil)
                    }
                }
            }
        }
    }
}

extension FinishGoalVC: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if pointsTextField.text == "0" {
            pointsTextField.text = ""
            return true
        }else{
            return true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if pointsTextField.text == ""{
            pointsTextField.text = "0"
            return true
        }else{
            return true
        }
    }
    
    func save(completion: (_ success: Bool)->()){
        let goal = Goal(context: context)
        goal.goalDescription = self.goal
        goal.goalType = self.goalType.rawValue
        goal.goalCompletionValue = Int32(self.pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        do{
            try context.save()
            completion(true)
        }catch{
            debugPrint("Error ❌ \(error.localizedDescription)")
            completion(false)
        }
    }
}


