//
//  AddStudentViewController.swift
//  TestApp
//
//  Created by Users on 12/21/18.
//  Copyright © 2018 Poom Penghiran. All rights reserved.
//

import UIKit

class AddStudentViewController: UIViewController {
    
    var studentItem: Student? = Student()
    var tbKeyboard: UIToolbar?
    var currentText: UITextField?
    @IBOutlet weak var tableView: UITableView!
    var spaceAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let _ = studentItem?.ref {
            title = "Edit Student"
        }
        
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height)
        tableView.tableFooterView = UIView(frame: rect)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelPressed(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        done()
    }
    
    func done() {
        studentItem?.save()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension AddStudentViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ref_editItem") as? PersonalEditCell {
            let position = indexPath.item
            cell.configure(info: PersonalRecords.records[position], student: studentItem!)
            cell.fieldValue.delegate = self
            cell.fieldValue.tag = position + 1
            return cell
        }
        return UITableViewCell()
    }
    
    // Get number of item in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonalRecords.records.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let position = textField.tag
        
        currentText = textField
        
        // if there's no tool bar, create it
        if tbKeyboard == nil {
            tbKeyboard = UIToolbar.init(frame: CGRect.init(x: 0, y: 0,
                                                           width: self.view.frame.size.width, height: 44))
            let bbiPrev = UIBarButtonItem.init(title: "Previous",
                                               style: .plain, target: self, action: #selector(previousField))
            let bbiNext = UIBarButtonItem.init(title: "Next", style: .plain,
                                               target: self, action: #selector(nextField))
            let bbiSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
            let bbiSubmit = UIBarButtonItem.init(title: "Done", style: .plain,
                                                 target: self, action: #selector(done))
            tbKeyboard?.items = [bbiPrev, bbiNext, bbiSpacer, bbiSubmit]
        }
        
        tbKeyboard?.items?[0].isEnabled = position > 1
        tbKeyboard?.items?[1].isEnabled = position < PersonalRecords.records.count
        
        // set the tool bar as this text field's input accessory view
        textField.inputAccessoryView = tbKeyboard
        return true
    }
    
    func previousField() {
        guard let textField = currentText else { return }
        let nextTag = textField.tag - 1
        // Try to find next responder
        let nextResponder = textField.superview?.superview?.superview?.viewWithTag(nextTag) as UIResponder!
        
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
    }
    
    func nextField() {
        guard let textField = currentText else { return }
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.superview?.superview?.viewWithTag(nextTag) as UIResponder!
        
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let nextResponder = tableView.viewWithTag(1) as UIResponder!
        nextResponder?.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.superview?.superview?.viewWithTag(nextTag) as UIResponder!
        
        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
 */

}
