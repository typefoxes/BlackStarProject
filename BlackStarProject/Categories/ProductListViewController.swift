

import UIKit
import Alamofire

protocol ProductViewControllerDelegate {
    func loadId(id: String)
}

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var subCollectionView: UICollectionView!
    
    var idDelegate: ProductViewControllerDelegate?
    var screenName = ""
    var product: [Product] = []
    
    func newProductLoad() {
           let urlString = "https://fakestoreapi.com/products/category/\(screenName)"
           guard let url = URL(string: urlString) else { return }

           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   print(error)
               }
               
               guard let data = data else {
                   return
               }
                   do
                       {
               let products = try JSONDecoder().decode([Product].self, from: data)
                           DispatchQueue.main.async {
                               self.product = products
                               self.subCollectionView.reloadData()
           }
       }
               catch {
                   print(error)
               }
           }.resume()
           }
       
    

    override func viewDidLoad() {
        super.viewDidLoad()
        subCollectionView.delegate = self
        subCollectionView.dataSource = self
        navigationItem.title = self.screenName
        newProductLoad()
                }


}
extension ProductListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCell", for: indexPath) as! ProductCollectionViewCell
        let model = product[indexPath.item]
        cell.subPriceLabel.text = String(model.price!) + " " + "USD"
        cell.subNameLabel.text = model.title
        cell.subImageView.layer.cornerRadius = 20
        
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        cell.tintColor = UIColor.lightGray

        
        if let url = URL(string: model.image) {
        
            if let data = NSData(contentsOf: url), let imageFromData = UIImage(data: data as Data ) {
                
                cell.subImageView.image = imageFromData
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "fullProduct") as? FullProductViewController else {
                fatalError("Unable to Instantiate Prodyct View Controller")
            }
           
            let model = product[indexPath.item]
           
            detailsViewController.name = model.title
            detailsViewController.price = String(round(model.price!)) + " " + "USD"
            detailsViewController.detDes = model.description
            detailsViewController.product = [model]
            detailsViewController.image = model.image
            detailsViewController.categoryNameDetails = screenName
     
                present(detailsViewController, animated: true)
        }
            
}
