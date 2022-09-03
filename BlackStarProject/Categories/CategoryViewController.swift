import UIKit
import RealmSwift
import Alamofire

struct Category {
    let name: String
}

class CategoryViewController: UIViewController {

    var categories: [Category] = []

    @IBOutlet weak var categoriesTableView: UITableView!
    
    func loadData() { AF.request("https://fakestoreapi.com/products/categories").responseDecodable(of: [String].self) { response in guard let categories = response.value else { return }
            DispatchQueue.main.async { [weak self] in
                self?.categories = categories.map(Category.init)
                self?.categoriesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "subSegue",
              let destination = segue.destination as? ProductListViewController,
              let cell = sender as? UITableViewCell,
              let i = categoriesTableView.indexPath(for: cell) {
               if categories[i.row].name == "men's clothing" {
               destination.screenName = "men's%20clothing"
           }
               if categories[i.row].name == "women's clothing" {
                  destination.screenName = "women's%20clothing"
               }
               if categories[i.row].name == "jewelery" {
                   destination.screenName = "jewelery"
               }
               if categories[i.row].name == "electronics" {
                   destination.screenName = "electronics"
            }
     }
   }
}

    
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
        
   
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoriesCellTableViewCell
        
        cell.categoryNameLabel.text = categories[indexPath.row].name
        cell.categoryImageView.layer.cornerRadius = 23
        
        if cell.categoryNameLabel.text == "men's clothing" {
            cell.categoryImageView.image = UIImage(named: "mans")
        }
        if cell.categoryNameLabel.text == "jewelery" {
            cell.categoryImageView.image = UIImage(named: "ring")
        }
        if cell.categoryNameLabel.text == "electronics" {
            cell.categoryImageView.image = UIImage(named: "electro")
        }
        if cell.categoryNameLabel.text == "women's clothing" {
            cell.categoryImageView.image = UIImage(named: "lady")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoriesTableView.deselectRow(at: indexPath, animated: true)

    }
   
}

