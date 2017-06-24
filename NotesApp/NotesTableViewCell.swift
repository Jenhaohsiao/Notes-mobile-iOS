//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Jenhao on 2016-12-09.
//  Copyright © 2016 Jenhao.ca. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelCellSubtitle: UILabel!

    @IBOutlet weak var ImageCell: UIImageView!

    @IBOutlet weak var LabelCellDate: UILabel!

    @IBOutlet weak var LabelDetail: UILabel!

    @IBOutlet weak var MapsIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
