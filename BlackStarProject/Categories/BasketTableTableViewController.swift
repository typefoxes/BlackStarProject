
import UIKit
import RealmSwift
class BasketTableTableViewController: UITableViewController {
    
    //MARK: сообщили контроллеру откуда брать данные
    
    let realm = try! Realm()
    var items: Results<ProductList>!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            items = realm.objects(ProductList.self)
        }

    //MARK: колличество секций
override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    //MARK: колличество ячеек
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return items.count }

    //MARK: заполняем ячейки
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell") as! BasketTableViewCell // сообщили, что ячейка может быть переиспользована
        let item = items[indexPath.row]
    
        cell.basketName?.text = item.name
        cell.basketPrice?.text = item.price

    //MARK: загрузили картинку
        if let url = URL(string: item.image) {
            if let data = NSData(contentsOf: url), let imageFromData = UIImage(data: data as Data ) {
            cell.basketImage?.image = imageFromData }
         }
            return cell
     }
    
    //MARK: добавили возможность изменения ячейки
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return true }


    //MARK: добавили возможность удалять ячейку и данные из хранения реалм
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        try! realm.write {
            realm.delete(items[indexPath.row])
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert { }
        tableView.reloadData()
    }
    //MARK: анимация
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
