
import UIKit
import RealmSwift
class BasketTableTableViewController: UITableViewController {
    let realm = try! Realm()
        var items: Results<ProductList>!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            items = realm.objects(ProductList.self)
        }

        // MARK: - Table view data source
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return items.count
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell") as! BasketTableViewCell
             let item = items[indexPath.row]
             cell.basketName?.text = item.name
             cell.basketPrice?.text = item.price

             if let url = URL(string: item.image) {
                 if let data = NSData(contentsOf: url), let imageFromData = UIImage(data: data as Data ) {
                     cell.basketImage?.image = imageFromData
                     
                     }
         }
            return cell
     }
     
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
                return true
            }



    // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        
        
        try! realm.write {
            realm.delete(items[indexPath.row])
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
     
    }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    }
