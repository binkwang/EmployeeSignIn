//
//  StaffCell.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 5/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kStaffCellReuseIdentifier = "StaffCell"

class StaffCell: UITableViewCell {
    
    var staff: Staff? {
        didSet {
            DispatchQueue.main.async {
                self.nameLabel.text = self.staff?.displayName
                self.avatarImageView.renderCellImage(imageUrl: self.staff?.photoURL)
            }
        }
    }
    
    var isSelectedStatus: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.statusImageView.image = self.isSelectedStatus ? UIImage(named: "Selected") : UIImage(named: "NoSelect")
            }
        }
    }
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
    }
}

