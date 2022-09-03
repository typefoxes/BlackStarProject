import Foundation
import RealmSwift

struct DataAllSub: Hashable,Codable {
    let title: String
    
enum CodingKeys: String, CodingKey { case title = "title" }
}
class saveItSub: Object { @objc dynamic var title: String? = "" }
