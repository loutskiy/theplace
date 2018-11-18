//
//  FavoriteCell.swift
//  MapIT
//
//  Created by Mikhail Lutskiy on 18/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var imageViewMap: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
