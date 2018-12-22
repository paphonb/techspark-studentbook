//
//  PersonalHeaderCell.swift
//  TestApp
//
//  Created by Users on 12/21/18.
//  Copyright © 2018 Poom Penghiran. All rights reserved.
//

import UIKit

class PersonalHeaderCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myImageView.layer.cornerRadius = myImageView.frame.size.width / 2
        myImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(student: Student) {
        myImageView.af_setImage(withURL: student.getImageURL())
        nameLabel.text = student.getFullName()
    }

}
