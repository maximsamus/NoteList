//
//  NewTaskViewController.swift
//  Notes
//
//  Created by Максим Самусь on 07.07.2022.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
//        taskTextView.becomeFirstResponder()
        setupTextView()
    }
    
    private func setupTextView() {
        taskTextView.becomeFirstResponder()
        if let task = task {
            taskTextView.text = task.title
            prioritySegmentedControl.selectedSegmentIndex = Int(task.priority)
        } else {
            doneButton.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let title = taskTextView.text, !title.isEmpty else { return }
        let priority = Int16(prioritySegmentedControl.selectedSegmentIndex)
        if let task = task {
            StorageManager.shared.edit(task: task, with: title, and: priority)
        } else {
            StorageManager.shared.saveTask(withTitle: title, andPriority: priority)
        }
        dismiss(animated: true)
    }
    
}

extension NewTaskViewController: UITextViewDelegate {
    @objc private func keyboardWillShow(with notification: Notification) {
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let keyboardFrame = notification.userInfo?[key] as? CGRect else { return }
//                bottomConstraint.constant = keyboardFrame.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.textColor = .white
        if doneButton.isHidden {
            textView.text.removeAll()
            doneButton.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
}
