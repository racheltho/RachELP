//
//  FilterTableViewCell.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/13/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

protocol FilterViewCellDelegate : class {
    func filterView(filterCell: FilterTableViewCell, didChangeSwitchValue value: Bool)
}

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    weak var delegate: FilterViewCellDelegate?
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        println("switch changed")
        delegate?.filterView(self, didChangeSwitchValue: filterSwitch.on)
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
