//
//  HomeTableViewCell.swift
//  FutureNote
//
//  Created by Other on 23/4/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet var labelTitle:UILabel!
    @IBOutlet var labelCreateAt:UILabel!
    @IBOutlet var labelContent:UILabel!
    @IBOutlet var arrowImage:UIImageView!
    @IBOutlet var vContainer:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        vContainer.layer.cornerRadius = 15
        vContainer.layer.masksToBounds = false
        
        labelContent.textAlignment = .left
        labelContent.numberOfLines = 3
        labelContent.contentMode = .top
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
