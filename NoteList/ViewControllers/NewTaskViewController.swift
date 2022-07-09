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
