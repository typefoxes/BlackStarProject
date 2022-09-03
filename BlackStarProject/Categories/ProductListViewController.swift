

import UIKit
import Alamofire


class ProductListViewController: UIViewController {
    
    @IBOutlet weak var subCollectionView: UICollectionView!

//MARK: создаем данные для последующего заполнения
    var screenName = "" //сюда передаются нужное название категории уже в готовом формате для будущей функции загрузки
    var product: [Product] = []
    
//MARK: создаем функцию загрузки продуктов из категой
    func newProductLoad() {
           let urlString = "https://fakestoreapi.com/products/category/\(screenName)" //создали ссылку для загрузки данных
           guard let url = URL(string: urlString) else { return }

           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error { print(error) }
               guard let data = data else { return }
                   do {
               let products = try JSONDecoder().decode([Product].self, from: data)
                        DispatchQueue.main.async {
                        self.product = products
                        self.subCollectionView.reloadData()
           }
       } catch { print(error) }
    }.resume()
}

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = self.screenName
        newProductLoad()
        }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
//MARK: колличесво ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return product.count }
  
//MARK: заполняем ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCell", for: indexPath) as! ProductCollectionViewCell
        let model = product[indexPath.item]
        cell.subPriceLabel.text = String(model.price!) + " " + "USD"
        cell.subNameLabel.text = model.title
        cell.subImageView.layer.cornerRadius = 20
        
//MARK: задали несколько параметров отображения ячеек
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        cell.tintColor = UIColor.lightGray

//MARK: загрузили картинку
        if let url = URL(string: model.image) {
        if let data = NSData(contentsOf: url), let imageFromData = UIImage(data: data as Data ) { cell.subImageView.image = imageFromData }
        }
        return cell
    }
//MARK: прописываем действия при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            guard let fullProductViewController = storyboard.instantiateViewController(withIdentifier: "fullProduct") as? FullProductViewController else {
                fatalError("Unable to Instantiate Prodyct View Controller")
            }
           
        let model = product[indexPath.item]
           
        fullProductViewController.name = model.title
        fullProductViewController.price = String(round(model.price!)) + " " + "USD"
        fullProductViewController.detDes = model.description
        fullProductViewController.product = [model]
        fullProductViewController.image = model.image
        fullProductViewController.categoryNameDetails = screenName
     
        present(fullProductViewController, animated: true)
        }
}
