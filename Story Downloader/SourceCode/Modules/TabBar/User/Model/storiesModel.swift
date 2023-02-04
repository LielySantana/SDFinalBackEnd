
import Foundation


struct StoriesModel: Decodable{
    var count: Int?
    var Sdata: [Storiesdata]
    var storiesMedia: [StoriesMedia]
    
    enum CodingKeys: String, CodingKey{
        case count
        case data
        case pk
//        case storiesUrl
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.Sdata = try container.decode([Storiesdata].self, forKey: .data)
        self.storiesMedia = try container.decode([StoriesMedia].self, forKey: .data)
        
        
    }
}

struct Storiesdata: Codable{
    var pk: String
   
    
}

struct video_versions: Codable {
    var url: String
    
}
struct image_versions2: Codable{
    var candidates: [candidates]?

}

struct candidates: Codable{
    var url: String 
}


struct StoriesMedia: Codable {
    var video_versions: [video_versions]?
    var image_versions2: [String: [candidates]]?
}

