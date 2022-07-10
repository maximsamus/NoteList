//
//  TaskListViewController.swift
//  Notes
//
//  Created by Максим Самусь on 07.07.2022.
//

import UIKit
import CoreData

class TaskListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var fetchedResulstController = StorageManager.shared.fetchedResultsController(
        entityName: "Task",
        keysForSort: ["isComplete", "date"]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResulstController.delegate = self
        do {
            try fetchedResulstController.performFetch()
        } catch {
            print(error)
        }
    }
    
    private func getTask(at indexPath: IndexPath?) -> Task? {
        if let indexPath = indexPath {
            return fetchedResulstController.object(at: indexPath) as? Task
        }
        return nil
    }
    
    private func setContentForCell(with task: Task?) -> UIListContentConfiguration {
        var content = UIListContentConfiguration.cell()
        
        content.textProperties.font = UIFont(
            name: "Avenir Next Medium", size: 23
        ) ?? UIFont.systemFont(ofSize: 23)
        
        content.textProperties.color = .darkGray
        content.text = task?.title
        content.attributedText = strikeThrough(string: task?.title ?? "", task?.isComplete ?? false)
        
        return content
    }
    
    private func strikeThrough(string: String, _ isStrikeThrough: Bool) -> NSAttributedString {
        var attributedString = NSAttributedString(
            string: string,
            attributes: [NSAttributedString.Key.strikethroughStyle : 0]
        )
        
        if isStrikeThrough {
            attributedString = NSAttributedString(
                string: string,
                attributes: [
                    NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.double.rawValue
                ]
            )
        }
        return attributedString
    }
    
}

// MARK: - Table View Data Soutce
extension TaskListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResulstController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = getTask(at: indexPath)
        cell.contentConfiguration = setContentForCell(with: task)
        return cell
    }
}



