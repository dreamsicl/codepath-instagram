//
//  TableSectionHeader.swift
//  Insta
//
//  Created by Vanna Phong on 3/26/17.
//  Copyright © 2017 Vanna Phong. All rights reserved.
//

import UIKit

class TableSectionHeader: UITableViewHeaderFooterView {

    public static var height = CGFloat(45)
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
