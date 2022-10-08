//
//  UsersTableViewCell.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelFollowers: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
