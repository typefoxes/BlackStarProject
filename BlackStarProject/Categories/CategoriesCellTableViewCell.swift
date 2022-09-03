//
//  CategoriesCellTableViewCell.swift
//  BlackStarProject
//
//  Created by Fox on 01.09.2022.
//

import UIKit

class CategoriesCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    

    override func awakeFromNib() { super.awakeFromNib() }

    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(selected, animated: animated) }

}
