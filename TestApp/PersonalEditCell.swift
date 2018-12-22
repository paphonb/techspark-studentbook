//
//  PersonalEditCell.swift
//  TestApp
//
//  Created by Users on 12/21/18.
//  Copyright © 2018 Poom Penghiran. All rights reserved.
//

import UIKit

class PersonalEditCell: UITableViewCell {

    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var fieldValue: UITextField!
    
    var name: String = ""
    var student: Student?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(info: PersonalRecords.RecordInfo, student: Student) {
        fieldLabel.text = info.label
        fieldValue.autocapitalizationType = info.capType
        fieldValue.keyboardType = info.kbType
        fieldValue.text = student.values[info.field] ?? ""
        self.name = info.field
        self.student = student
    }
    
    @IBAction func valueChanged(_ sender: Any) {
    }

    @IBAction func editingChanged(_ sender: Any) {
        student?.values[name] = fieldValue.text
    }
}
