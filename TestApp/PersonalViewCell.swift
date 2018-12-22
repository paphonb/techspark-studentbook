//
//  PersonalViewCell.swift
//  TestApp
//
//  Created by Users on 12/21/18.
//  Copyright © 2018 Poom Penghiran. All rights reserved.
//

import UIKit

class PersonalViewCell: UITableViewCell {

    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var fieldValue: UILabel!
    
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
        fieldValue.text = student.values[info.field] ?? ""
    }

}
