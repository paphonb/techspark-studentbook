//
//  StudentViewController.swift
//  TestApp
//
//  Created by Users on 12/21/18.
//  Copyright © 2018 Poom Penghiran. All rights reserved.
//

import UIKit

class StudentViewController: UITabBarController, UITabBarControllerDelegate {
    
    var studentItem: Student?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
        navigationItem.rightBarButtonItem = viewControllers?[0].navigationItem.rightBarButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setStudent(student: Student) {
        studentItem = student
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        navigationItem.rightBarButtonItem = viewControllers?[selectedIndex].navigationItem.rightBarButtonItem
        if (selectedIndex == 1) {
            title = studentItem?.getFullName()
        } else {
            title = ""
        }
    }

}
