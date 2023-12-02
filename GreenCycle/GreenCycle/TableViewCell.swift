//
//  TableViewCell.swift
//  GreenCycle
//
//  Created by 김민경 on 12/2/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var basicImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
