

import UIKit
import RealmSwift

class FullProductViewController: UIViewController {


    let realm = try! Realm()
    //MARK: необходимые переменные для отображения
       var name = " "
       var price = " "
       var detDes = " "
       var product: [Product] = []
       var image = " "
       var categoryNameDetails = " "
    
    //MARK: связали объекты из сториборда с кодом
    
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsName: UILabel!
    @IBOutlet weak var detailsPrice: UILabel!
    @IBOutlet weak var detailsDescription: UILabel!
    
    //MARK: добавили действия по нажатию на кнопку
    
    @IBAction func addToBasket(_ sender: Any) {
        
    //MARK: сохраняем данные о товаре в Реалм и передаем данные на экран корзины
        let realmBasket = ProductList()
               
               realmBasket.name = name
               realmBasket.price = price
               realmBasket.image = image
               
               try! realm.write {  realm.add(realmBasket) }
        
    //MARK: добавили всплывающее уведомление об успешном добавлении
        let alert = UIAlertController(title: "👍🏻", message: "Товар добавлен в корзину", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            
    //MARK: добавили действие, при ответе на уведомление текущий экран закроется
            
            if let nvc = self.navigationController { nvc.popViewController(animated: true) }
            else { self.dismiss(animated: true, completion: nil) }
 }))
    //MARK: запускаем код уведомления
        self.present(alert, animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //MARK: выводим нужные данные на экран
        
        detailsPrice.text! = price
        detailsDescription.text! = detDes
        detailsName.text! = name
        
    //MARK: подгружаем картинку
        
        if let url = URL(string: image) {
        if let data = NSData(contentsOf: url), let imageFromData = UIImage(data: data as Data ) {
    detailsImage.image = imageFromData }
    detailsImage.clipsToBounds = true }

}
}
