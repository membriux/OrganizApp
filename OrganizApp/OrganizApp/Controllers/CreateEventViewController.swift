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
    
    // Shuts off the datePicker when the view is tapped
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // Changes the text while the date is being picked
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.eventDateAndTime
        eventDateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    // Pops up the date picker and hides it when the user taps on the CreateEventViewController
    func configureDatePickers() {
        
        datePicker.datePickerMode = .dateAndTime
        
        datePicker.addTarget(self, action: #selector(CreateEventViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateEventViewController.viewTapped(gestureRecognizer:)))
        
        
        view.addGestureRecognizer(tapGesture)
        
        eventDateTextField.inputView = datePicker
        
    }
    
    
}























