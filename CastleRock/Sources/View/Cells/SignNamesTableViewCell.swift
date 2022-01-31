//
//  SignNamesTableViewCell.swift
//  CastleRock
//
//  Created by Venkata Pranathi Immaneni on 1/22/22.
//

import UIKit

/*
***************************************************
*****************  SignNamesTableViewCell  ***************
***************************************************
*/

class SignNamesTableViewCell: UITableViewCell {

    /*
     ***********  IBOutlet Properties  ***********
    */
    @IBOutlet weak var signDisplayName: UILabel!
    
    /*
     ***********  Overrides  ***********
    */
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
