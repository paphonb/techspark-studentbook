//
//  StudentItemCell.swift
//  TestApp
//
//  Created by Users on 12/21/18.
//  Copyright © 2018 Poom Penghiran. All rights reserved.
//

import UIKit

class StudentItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(student: Student) {
        nameLabel.text = student.getFullName()
        idLabel.text = "ID: \(student.values["studentNumber"] ?? "")"
        profileImage.af_setImage(withURL: student.getImageURL())
    }
    
}
