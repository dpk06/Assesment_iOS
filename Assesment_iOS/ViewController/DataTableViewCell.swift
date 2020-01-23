//
//  DataTableViewCell.swift
//  Assesment_iOS
//
//  Created by Developer on 21/01/20.
//  Copyright © 2020 Developer. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var description_Label: UILabel!
    @IBOutlet weak var tittle_Label: UILabel!
    @IBOutlet weak var cell_ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
