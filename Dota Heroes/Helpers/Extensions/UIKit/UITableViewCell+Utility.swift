//
//  CoreTableViewCell.swift
//  MySiloam
//
//  Created by DSS-Titus on 10/08/21.
//  Copyright © 2021 siloamhospital. All rights reserved.
//

import UIKit.UITableViewCell

extension UITableViewCell {
    
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
        
        let doneButtonDateSleep = UIBarButtonItem(title: "label_done".localized(), style: UIBarButtonItem.Style.plain, target: self, action: doneAction)
        let spaceButtonDateSleep = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButtonDateSleep = UIBarButtonItem(title: "label_cancel".localized(), style: UIBarButtonItem.Style.plain, target: self, action: cancelAction)
        
        toolbar.setItems([cancelButtonDateSleep, spaceButtonDateSleep, doneButtonDateSleep], animated: false)
        toolbar.isUserInteractionEnabled = true
                
        for field in textField {
            field.inputView = picker
            field.inputAccessoryView = toolbar
        }
    }
    
    //not date picker
    func createNewPicker(datasource: UIPickerViewDataSource, delegate: UIPickerViewDelegate, picker: UIPickerView, doneAction: Selector, cancelAction: Selector = #selector(cancelPicker), textField: [UITextField]) {
        //only fill cancelAction if cancel have specific action, else use default
        
        //to handle safe are on iphone with notch (different safe area to superview on ip with & without notch)
        
        picker.dataSource = datasource
        picker.delegate = delegate
        picker.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    @objc func cancelPicker() {
        self.endEditing(true)
    }
}
