import Foundation

//MARK: создали модель данных JSON и инициализировали
struct Product: Decodable {
    let id: Int
    let title: String
    let price: Double?
    let description: String
    let category: String
    let image: String
    
    
    init?(data: NSDictionary){
        guard let title = data["title"] as? String,
              let description = data["description"] as? String,
              let image = data["image"] as? String,
              let price = data["price"] as? Double,
              let id = data["id"] as? Int,
              let category = data["category"] as? String
                
        else { return nil }
        
        self.title = title
        self.description = description
        self.image = image
        self.price = price
        self.category = category
        self.id = id
    }
  
}
