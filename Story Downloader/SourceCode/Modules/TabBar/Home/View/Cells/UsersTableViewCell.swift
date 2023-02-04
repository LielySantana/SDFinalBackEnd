//
//  UsersTableViewCell.swift
//  Story Downloader
//
//  Created by Mohit Kumar Mohit on 08/10/22.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var userid: Int!
    var userData: UserUser!
    var userInfo: UserElement!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //   Configure the view for the selected state
        
        
    }
    
}
