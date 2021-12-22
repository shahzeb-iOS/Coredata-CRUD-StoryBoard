//
//  ShowRecordTableViewCell.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 18/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import UIKit

class ShowRecordTableViewCell: UITableViewCell {
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var email:UILabel!
    @IBOutlet weak var dateofBirth:UILabel!
    @IBOutlet weak var cellNumber:UILabel!
    @IBOutlet weak var imageShow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
