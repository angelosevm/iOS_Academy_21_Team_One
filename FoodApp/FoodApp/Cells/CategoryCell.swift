//
//  CellCategory.swift
//  FoodApp
//
//  Created by Panagiota on 1/12/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    @IBOutlet weak var categoryCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
}
