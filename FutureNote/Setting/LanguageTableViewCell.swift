//
//  LanguageTableViewCell.swift
//  FutureNote
//
//  Created by Other on 21/4/25.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    
    @IBOutlet var flag:UIImageView!
    @IBOutlet weak var languageName:UILabel!
    @IBOutlet weak var tick:UIImageView!
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
