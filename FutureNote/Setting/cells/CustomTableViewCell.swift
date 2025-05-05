//
//  CustomTableViewCell.swift
//  FutureNote
//
//  Created by Other on 16/4/25.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet var label:UILabel!
    @IBOutlet var view:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
