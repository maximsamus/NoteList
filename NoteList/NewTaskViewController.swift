//
//  NewTaskViewController.swift
//  Notes
//
//  Created by Максим Самусь on 07.07.2022.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var taskTextView: UITextView!
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
//    @objc private func keyboardWillShow(with notification: Notification) {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        taskTextView.becomeFirstResponder()
    }
    
    

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func doneButtonPressed(_ sender: Any) {
    }
    
}

extension NewTaskViewController {
    @objc private func keyboardWillShow(with notification: Notification) {
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let keyboardFrame = notification.userInfo?[key] as? CGRect else { return }
//        bottomConstraint.constant = keyboardFrame.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
} }
}
