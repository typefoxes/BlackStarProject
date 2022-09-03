

import UIKit
import RealmSwift

class FullProductViewController: UIViewController {

    let realm = try! Realm()
       
       var name = " "
       var price = " "
       var detDes = " "
       var product: [Product] = []
       var image = " "
       var categoryNameDetails = " "
    
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsName: UILabel!
    @IBOutlet weak var detailsPrice: UILabel!
    @IBOutlet weak var detailsDescription: UILabel!
    @IBAction func addToBasket(_ sender: Any) {
        let realmBasket = ProductList()
               
               realmBasket.name = name
               realmBasket.price = price
               realmBasket.image = image
               
               try! realm.write {
                   realm.add(realmBasket)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPrice.text! = price
        detailsDescription.text! = detDes
        detailsName.text! = name

        if let url = URL(string: image) {
        if let data = NSData(contentsOf: url), let imageFromData = UIImage(data: data as Data ) {
    detailsImage.image = imageFromData }
    detailsImage.clipsToBounds = true }

}
}
