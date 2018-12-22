//
//  PersonalRecords.swift
//  TestApp
//
//  Created by Users on 12/21/18.
//  Copyright © 2018 Poom Penghiran. All rights reserved.
//

import UIKit
import Foundation

class PersonalRecords {
    
    static let records = [
        RecordInfo(label: "Name", field: "name", kbType: .default, capType: .words),
        RecordInfo(label: "Surname", field: "surname", kbType: .default, capType: .words),
        RecordInfo(label: "Image URL", field: "imageURL", kbType: .URL, capType: .none),
        RecordInfo(label: "Student number", field: "studentNumber", kbType: .numberPad, capType: .none),
        RecordInfo(label: "Age", field: "age", kbType: .numberPad, capType: .none),
        RecordInfo(label: "Phone", field: "phone", kbType: .phonePad, capType: .none),
        RecordInfo(label: "Email", field: "email", kbType: .emailAddress, capType: .none),
        RecordInfo(label: "Academic track", field: "academicTrack", kbType: .default, capType: .words),
        RecordInfo(label: "Cumulative GPA", field: "gpax", kbType: .decimalPad, capType: .none)
    ]
    
    class RecordInfo {
        let label: String
        let field: String
        let kbType: UIKeyboardType
        let capType: UITextAutocapitalizationType
        
        init(label: String, field: String, kbType: UIKeyboardType, capType: UITextAutocapitalizationType) {
            self.label = label
            self.field = field
            self.kbType = kbType
            self.capType = capType
        }
    }
}
