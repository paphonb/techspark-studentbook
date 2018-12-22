//
//  PersonalViewController.swift
//  TestApp
//
//  Created by Users on 12/21/18.
//  Copyright © 2018 Poom Penghiran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PersonalViewController: UIViewController {
    
    var studentItem: Student?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchFirebase()
    }
    
    // Attach Firebase listener to this screen, monitoring for value changes
    private func fetchFirebase() {
        studentItem?.ref?.observe(.value, with: { (snapshot) in
            if (snapshot.value != nil) {
                self.studentItem = Student(snapshot: snapshot)
                self.tableView.reloadData()
            }
        })
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

    @IBAction func editClicked(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ref_additem") as? UINavigationController {
            let avc = vc.topViewController as! AddStudentViewController
            avc.studentItem = studentItem
            present(vc, animated: true, completion: nil)
        }
    }
    
}

extension PersonalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 1) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ref_personalItem") as? PersonalViewCell {
                cell.configure(info: PersonalRecords.records[indexPath.item + 3], student: studentItem!)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ref_personalHeader") as? PersonalHeaderCell {
                cell.configure(student: studentItem!)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // Get number of item in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 1) {
            return PersonalRecords.records.count - 3
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 1) {
            return 64
        } else {
            return 200
        }
    }

}
