//
//  ViewController.swift
//  TestApp
//
//  Created by Poom Penghiran on 12/18/2561 BE.
//  Copyright © 2561 Poom Penghiran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var ref: DatabaseReference!
    var studentList: [Student] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        ref = Database.database().reference(withPath: "students")
        fetchFirebase()
        
        if (traitCollection.forceTouchCapability == .available) {
            registerForPreviewing(with: self, sourceView: view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFirebase()
    }
    
    // Function when add new item button is clicked
    @IBAction func addItemClicked(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ref_additem") {
            present(vc, animated: true, completion: nil)
        }
    }
    
    // Attach Firebase listener to this screen, monitoring for value changes
    private func fetchFirebase() {
        ref.observe(.value, with: { (snapshot) in
            var newItem: [Student] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let item = Student(snapshot: snapshot) {
                    newItem.append(item)
                }
            }
            self.studentList = newItem
            self.tableView.reloadData()
            self.loadingIndicator.stopAnimating()
        })
    }
    
    // Configuring the tableView
    private func configureTableView() {
        tableView.register(UINib(nibName: "StudentItemCell", bundle: Bundle.main) , forCellReuseIdentifier: "ref_studentItemCell")
    }

}

// Function required for creating tableView
extension ViewController: UITableViewDataSource, UITableViewDelegate, UIViewControllerPreviewingDelegate {
    
    // Populating tableView cells for each item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ref_studentItemCell") as? StudentItemCell {
            cell.set(student: studentList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // Set size for each tableView cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    // Get number of item in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    // Add action button for each tableView cell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        /*
        // Edit action
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action: UITableViewRowAction, indexPath: IndexPath) in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ref_additem") as? AddItemViewController {
                vc.isEdit = true
                vc.groceryItem = self.studentList[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        */
        
        // Delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action: UITableViewRowAction, indexPath: IndexPath) in
            self.studentList[indexPath.row].ref?.removeValue()
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ref_viewPersonal") as? PersonalViewController {
            let student = studentList[indexPath.item]
            vc.studentItem = student
            vc.title = ""
            //vc.setStudent(student: student)
            //(vc.viewControllers?[0] as! PersonalViewController).studentItem = student
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ref_viewPersonal") as? PersonalViewController {
            let student = studentList[indexPath.item]
            vc.studentItem = student
            vc.title = ""
            vc.preferredContentSize = CGSize(width: 0.0, height: 300)
            previewingContext.sourceRect = cell.frame            //vc.setStudent(student: student)
            //(vc.viewControllers?[0] as! PersonalViewController).studentItem = student
            return vc
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
    
}


