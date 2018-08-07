//
//  CreateEventViewController.swift
//  OrganizApp
//
//  Created by Memo on 8/1/18.
//  Copyright © 2018 Membriux. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateEventViewController: UIViewController {
    
    var datePicker = UIDatePicker()
    let admin = Admin.current
    

    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventDateTextField: UITextField!
    @IBOutlet weak var eventURLTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextView: UITextView!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePickers()
        configureTextFieldInputs()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // .default
    }
    
    // Create an event and upload it to firebase
    @IBAction func createEventButtonTapped(_ sender: Any) {
        
        // Get inputs for creating event
        guard let title = eventTitleTextField.text,
            let location = eventLocationTextField.text,
            let date = eventDateTextField.text,
            let url = eventURLTextField.text,
            let notes = eventDescriptionTextView.text,
        !title.isEmpty && !location.isEmpty && !date.isEmpty
            else { print("Should contain at least title, date, and location"); return  }
        
        // Create event if required inputs are valid
        EventService.create(orgUid: admin.managingOrgId , title: title, location: location, dateAndTime: date, notes: notes, url: url) { (event) in
            guard let _ = event else { return }
        }
        eventCreatedSuccess()

    }
    
    func eventCreatedSuccess() {
        eventTitleTextField.text = ""
        eventLocationTextField.text = ""
        eventDateTextField.text = ""
        eventURLTextField.text = ""
        eventDescriptionTextView.text = ""
        
        createEventButton.setTitle("Done!", for: .normal)
        createEventButton.backgroundColor = UIColor.gray
        self.view.endEditing(true)
    }
    
    

}


// Extension that handles the DatePicker functionality
extension CreateEventViewController {
    
    
    // Changes the text while the date is being picked
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.eventDateAndTime
        eventDateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func configureTextFieldInputs() {
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        
        let leadingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        
        toolbar.setItems([leadingFlex, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        //setting toolbar as inputAccessoryView
        self.eventTitleTextField.inputAccessoryView = toolbar
        self.eventLocationTextField.inputAccessoryView = toolbar
        self.eventDateTextField.inputAccessoryView = toolbar
        self.eventURLTextField.inputAccessoryView = toolbar
        self.eventDescriptionTextView.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    // Pops up the date picker and hides it when the user taps on the CreateEventViewController
    func configureDatePickers() {
        
        datePicker.datePickerMode = .dateAndTime
        
        datePicker.addTarget(self, action: #selector(CreateEventViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        eventDateTextField.inputView = datePicker
        
    }
    
    
}























