//
//  AddItemViewController.swift
//  TestApp
//
//  Created by Poom Penghiran on 12/18/2561 BE.
//  Copyright © 2561 Poom Penghiran. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var ui_title: UITextField!
    @IBOutlet weak var ui_subtitle: UITextField!
    @IBOutlet weak var ui_imageURL: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // Identify if it is editing screen
    var isEdit: Bool?
    var studentItem: Student?
    
    let ref = Database.database().reference(withPath: "students")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If it is editing screen, change the corresponding words
        if let edit = isEdit, edit {
            self.title = "Edit Student"
            /*
            if let item = studentItem {
                ui_title.text = item.name
                ui_subtitle.text = item.surname
                ui_imageURL.text = item.imageURL
            }
 */
        // If it is not editing, just only set navigation title text
        } else {
            self.title = "New Student"
        }
    }
    
    @IBAction func donePressed(_ sender: Any) {
        // Get user's input and validate the input
        guard let
            title = ui_title.text,
            let subtitle = ui_subtitle.text,
            let imageURL = ui_imageURL.text,
            title != "", subtitle != "", imageURL != "" else { return }
        
        if let edit = isEdit, let itemReference = studentItem, edit {
            // Case for editing the item
            itemReference.ref?.updateChildValues([
                "name" : title,
                "surname" : subtitle,
                "imageURL" : imageURL
                ])
        } else {
            // Case for adding new item
            //let obj = Student(name: title, surname: subtitle, imageURL: imageURL)
            //self.ref.childByAutoId().setValue(obj.toDictionary())
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
