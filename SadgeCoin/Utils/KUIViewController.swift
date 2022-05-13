//
//  KUIViewController.swift
//  SadgeCoin
//
//  Created by Rodolfo Castillo on 13/05/22.
//

import UIKit

class KUIViewController: UIViewController {
    
    var container: UIView = UIView()
    var bottomConstraintForKeyboard: NSLayoutConstraint?

    @objc func keyboardWillShow(sender: NSNotification) {
        let i = sender.userInfo!
        let s: TimeInterval = (i[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let k = (i[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        bottomConstraintForKeyboard?.constant = k
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let s: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        bottomConstraintForKeyboard?.constant = 0
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }

    @objc func clearKeyboard() {
        view.endEditing(true)
    }

    func keyboardNotifications() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func configureContainer() {
        container.removeFromSuperview()
        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraintForKeyboard = container.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        guard let bottomConstraintForKeyboard = bottomConstraintForKeyboard else {
            return
        }

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.view.topAnchor),
            container.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            container.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            bottomConstraintForKeyboard
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainer()
        keyboardNotifications()
        let t = UITapGestureRecognizer(target: self, action: #selector(clearKeyboard))
        view.addGestureRecognizer(t)
        t.cancelsTouchesInView = false
    }
}
