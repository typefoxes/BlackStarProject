

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var basketImage: UIImageView!
    @IBOutlet weak var basketName: UILabel!
    @IBOutlet weak var basketPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

    }

}
