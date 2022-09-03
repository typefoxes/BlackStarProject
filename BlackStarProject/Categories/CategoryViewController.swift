import UIKit
import RealmSwift
import Alamofire

struct Category {
    let name: String
}

class CategoryViewController: UIViewController {

    //MARK: создали массив в котором будем сохранять данные
    var categories: [Category] = []

    //MARK: соединили tablewiew с кодом
    @IBOutlet weak var categoriesTableView: UITableView!
    
    //MARK: создаем функцию загрузки данных с помощью библиотеки alamofire
    func loadData() { AF.request("https://fakestoreapi.com/products/categories").responseDecodable(of: [String].self) {
        response in guard let categories = response.value else {return}
            DispatchQueue.main.async { [weak self] in
                
    //MARK: добавили в массив полученные данные
                self?.categories = categories.map(Category.init)
    
    //MARK: перезагружаем таблицу для отображения полученных данных
                self?.categoriesTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//MARK: запускаем ранее прописанную функцию
        loadData()
    }
    
//MARK: пишем функцию перехода на следующий экран с выбранной категорией
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//MARK: прописываем какой именно переход нам нужен и куда
           if segue.identifier == "subSegue",
              let destination = segue.destination as? ProductListViewController,
//MARK: прописываем, что нажатие на ячейкау провоцирует переход
              let cell = sender as? UITableViewCell,
              let i = categoriesTableView.indexPath(for: cell) {
//MARK:прописывает отдельные условия так как данные в JSON немного некорректные
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

//MARK: колличество ячеек
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { categories.count }
    
//MARK: заполняем ячейку
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
//MARK: анимация
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoriesTableView.deselectRow(at: indexPath, animated: true)

    }
   
}

