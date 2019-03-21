//
//  WhyCustomTableViewCell.swift
//  Why iOS?
//
//  Created by shelby gold on 3/20/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class WhyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
    @IBOutlet weak var reasonWhyLabel: UILabel!
    
    //landingPad
    var why: Why?{
        didSet{
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateCell(){
        guard let why = why else {return}
        nameLabel.text = why.name
        cohortLabel.text = why.cohort
        reasonWhyLabel.text = why.reason
    }
    
}
