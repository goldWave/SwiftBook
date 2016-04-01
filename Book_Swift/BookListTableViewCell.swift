//
//  BookListTableViewCell.swift
//  Book_Swift
//
//  Created by 任金波 on 16/3/26.
//  Copyright © 2016年 任金波. All rights reserved.
//

import UIKit

class BookListTableViewCell: UITableViewCell {
    @IBOutlet weak var introImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var starView: UIView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
