//
//  CoreUIViewController.swift
//  MySiloam
//
//  Created by DSS-Titus on 10/08/21.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    //Used to Create Date Picker
    func createDatePicker(picker: UIDatePicker, mode: UIDatePicker.Mode = .date, doneAction: Selector, cancelAction: Selector = #selector(cancelPicker), textField: [UITextField]) {
        //only fill cancelAction if cancel have specific action, else use default

        //to handle safe are on iphone with notch (different safe area to superview on ip with & without notch)
        if #available(iOS 13.4, *) { picker.preferredDatePickerStyle = .wheels }

        picker.calendar = Calendar(identifier: .gregorian)
        picker.datePickerMode = mode

        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "label_done".localized(), style: UIBarButtonItem.Style.plain, target: self, action: doneAction)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "label_cancel".localized(), style: UIBarButtonItem.Style.plain, target: self, action: cancelAction)

        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        for field in textField {
            field.inputView = picker
            field.inputAccessoryView = toolbar
        }

        picker.layoutIfNeeded()
        picker.translatesAutoresizingMaskIntoConstraints = false
    }

    //not date picker
    func createNewPicker(datasource: UIPickerViewDataSource, delegate: UIPickerViewDelegate, picker: UIPickerView, doneAction: Selector, cancelAction: Selector = #selector(cancelPicker), textField: [UITextField]) {
        //only fill cancelAction if cancel have specific action, else use default

        //to handle safe are on iphone with notch (different safe area to superview on ip with & without notch)

        picker.dataSource = datasource
        picker.delegate = delegate

        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        let doneButtonDateSleep = UIBarButtonItem(title: "label_done".localized(), style: UIBarButtonItem.Style.plain, target: self, action: doneAction)
        let spaceButtonDateSleep = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButtonDateSleep = UIBarButtonItem(title: "label_cancel".localized(), style: UIBarButtonItem.Style.plain, target: self, action: cancelAction)

        toolbar.setItems([cancelButtonDateSleep, spaceButtonDateSleep, doneButtonDateSleep], animated: false)
        toolbar.isUserInteractionEnabled = true

        for field in textField {
            field.inputView = picker
            field.inputAccessoryView = toolbar
        }

        picker.layoutIfNeeded()
        picker.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func cancelPicker() {
        view.endEditing(true)
    }

    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        if let frame = frame {
            child.view.frame = frame
        }
        self.view.addSubview(child.view)
        child.view.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            child.view.alpha = 1
        } completion: { _ in
            child.didMove(toParent: self)
        }
    }

    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.view.alpha = 0.0
        } completion: { _ in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
}
