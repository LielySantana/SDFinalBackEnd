// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchModel = try? newJSONDecoder().decode(SearchModel.self, from: jsonData)

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    let users: [UserElement]
    
    enum CodingKeys: String, CodingKey {
        case users
    }
}



// MARK: - UserElement
struct UserElement: Codable {
    let position: Int
    let user: UserUser
}

// MARK: - UserUser
struct UserUser: Codable {
    let pk: Int
    let username: String
    let profilePicURL: String
    

    enum CodingKeys: String, CodingKey {
        case pk
        case username
        case profilePicURL = "profile_pic_url"
    }
    
    
    init(from decoder: Decoder) throws {
        var convertPk: Int = 0
        var container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.profilePicURL = try container.decode(String.self, forKey: .profilePicURL)
        do{
            convertPk = try container.decode(Int.self, forKey: .pk)
        } catch{
            convertPk = Int(try container.decode(String.self, forKey: .pk))!
        }
        self.pk = convertPk
    }
}


