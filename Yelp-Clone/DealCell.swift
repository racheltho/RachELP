//
//  DealCell.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/15/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

protocol DealCellDelegate : class {
    func dealView(DealCell: DealCell, didChangeSwitchValue value: Bool)
}

class DealCell: UITableViewCell {

    @IBOutlet weak var dealSwitch: UISwitch!
    weak var delegate: DealCellDelegate?
    
    @IBAction func dealSwitchDidChange(sender: AnyObject) {
        delegate?.dealView(self, didChangeSwitchValue: dealSwitch.on)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
