//
//  GoalVC.swift
//  GoalPost
//
//  Created by Faisal Babkoor on 8/30/18.
//  Copyright © 2018 Faisal Babkoor. All rights reserved.
//

import UIKit
import CoreData
class GoalVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoView: UIView!
    
    var goals = [Goal]()
    var goal: String = ""
    var goalType: GoalType = .shortTerm
    var goalProgressAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
    }
    
    @IBAction func undoBtnwasPressed(_ sender: Any) {
        context.undoManager?.undo()
        tableViewIsHidden()
        tableView.reloadData()
        UIView.animate(withDuration: 3) {
            self.undoView.alpha = 0.0
            self.undoView.isHidden = true
        }
    }
    
    fileprivate func tableViewIsHidden() {
        getData()
        if goals.count >= 1{
            tableView.isHidden = false
        }else{
            tableView.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewIsHidden()
        tableView.reloadData()
    }
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        presentDetail(createGoalVC)
    }
}
extension GoalVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? GoalCell{
            let goal = goals[indexPath.row]
            cell.configureCell(goal: goal)
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (action, indexPath) in
            self.deleteGoal(indexPath: indexPath)
            
            self.tableViewIsHidden()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.undoView.isHidden = false
        }
        
        let addAction = UITableViewRowAction(style: .default, title: "Add") { (action, indexPath) in
            self.undoView.isHidden = true
            self.setProgress(indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = .red
        addAction.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.6509803922, blue: 0.137254902, alpha: 1)
        if self.goals[indexPath.row].goalCompletionValue == self.goals[indexPath.row].goalProgress{
            return [deleteAction]
        }else{
            return [deleteAction, addAction]
            
        }
    }
    
    
}
extension GoalVC{
    func getData(){
        do{
            goals = try context.fetch(Goal.fetchRequest())
        }catch{
            debugPrint("Error ❌ \(error.localizedDescription)")
        }
    }
    
    func saveGoal(){
        do{
            try context.save()
            
        }catch{
            debugPrint("error \(error.localizedDescription)")
        }
    }
    
    func deleteGoal(indexPath: IndexPath){
        let goal = goals[indexPath.row]
        context.undoManager = UndoManager()
        context.delete(goal)
        do{
            try context.save()
            
        }catch{
            debugPrint("error \(error.localizedDescription)")
        }
    }
    
    func setProgress(indexPath: IndexPath){
        let goal = goals[indexPath.row]
        if goal.goalProgress < goal.goalCompletionValue{
            goal.goalProgress += 1
        }else{
            return
        }
        saveGoal()
    }
}
