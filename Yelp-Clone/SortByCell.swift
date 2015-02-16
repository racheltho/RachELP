//
//  SortByCell.swift
//  Yelp-Clone
//
//  Created by Rachel Thomas on 2/15/15.
//  Copyright (c) 2015 Rachel Thomas. All rights reserved.
//

import UIKit

protocol SortByCellDelegate : class {
    func sortByView(sortByCell: SortByCell, segmentValue value: Int)
}


class SortByCell: UITableViewCell {

    @IBOutlet weak var sortByControl: UISegmentedControl!
    weak var delegate: SortByCellDelegate?
    
    @IBAction func sortByValueChanged(sender: AnyObject) {
        println("in action")
        println(sortByControl.selectedSegmentIndex)
        delegate?.sortByView(self, segmentValue: sortByControl.selectedSegmentIndex)
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
