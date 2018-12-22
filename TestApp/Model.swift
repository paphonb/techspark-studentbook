//
//  Model.swift
//  TestApp
//
//  Created by Poom Penghiran on 12/18/2561 BE.
//  Copyright © 2561 Poom Penghiran. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Grocery {
    
    var ref: DatabaseReference?
    var title: String = ""
    var subtitle: String = ""
    var imageURL: String = ""
    
    init(title: String, subtitle: String, imageURL: String) {
        self.ref = nil
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let title = value["title"] as? String,
            let subtitle = value["subtitle"] as? String,
            let imageURL = value["imageURL"] as? String else { return nil }
        
        self.ref = snapshot.ref
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
    func toDictionary() -> Any {
        return ["title": title, "subtitle": subtitle, "imageURL": imageURL] as Any
    }
    
}

class Student {
    
    var ref: DatabaseReference?
    var values: [String: String] = [:]
    
    init() {
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        self.values = snapshot.value as! [String:String]
        self.ref = snapshot.ref
    }
    
    func getFullName() -> String {
        return "\(values["name"] ?? "") \(values["surname"] ?? "")"
    }
    
    func toDictionary() -> Any {
        return values
    }
    
    func save() {
        if (ref != nil) {
            ref?.updateChildValues(values)
        } else {
            Database.database().reference(withPath: "students").childByAutoId().setValue(values)
        }
    }
    
    func getImageURL() -> URL {
        if let urlString = values["imageURL"] {
            if let url = URL(string: urlString) {
                return url
            }
        }
        return URL(string: "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png")!
    }
}

extension Student: Equatable {
    static func == (lhs: Student, rhs: Student) -> Bool {
        return
            lhs.values == rhs.values
    }
}
