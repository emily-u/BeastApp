//
//  CustomCell.swift
//  redoBeast
//
//  Created by Emily on 1/30/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import Foundation
import UIKit

protocol cellDelegate: class {
    func beastCell(_ sender: CustomCell)
}

class CustomCell: UITableViewCell {
    
    var delegate: cellDelegate?
    
    @IBOutlet weak var showTitle: UILabel!
    
    @IBAction func beastButtonPressed(_ sender: UIButton) {
        delegate?.beastCell(self)
    }
    
}
