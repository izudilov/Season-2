//
//  NewsVK.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 06.02.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//


import Foundation
import Alamofire


// MARK: - Welcome

struct Welcome: Decodable {
    var response: Response
    
    enum CodingKeys: String, CodingKey {
         case response
     }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decode(Response.self, forKey: .response)
           
    }
}

// MARK: - Response

struct Response: Decodable {
    var items: [Item]
    var profiles: [Profile]
    var groups: [Group]
    var next_from: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case next_from
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Item].self, forKey: .items)
        self.profiles = try container.decode([Profile].self, forKey: .profiles)
        self.groups = try container.decode([Group].self, forKey: .groups)
        self.next_from = try container.decodeIfPresent(String.self, forKey: .next_from)
    }
}

// MARK: - Group

struct Group: Decodable {
    

    var id: Int
    var name: String
    var screen_name: String
    var is_closed: Int
    var type: String?
    var photo_50: String
    var photo_100: String
    var photo_200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screen_name
        case is_closed
        case type
        case photo_50
        case photo_100
        case photo_200
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.screen_name = try container.decode(String.self, forKey: .screen_name)
        self.is_closed = try container.decode(Int.self, forKey: .is_closed)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.photo_50 = try container.decode(String.self, forKey: .photo_50)
        self.photo_100 = try container.decode(String.self, forKey: .photo_100)
        self.photo_200 = try container.decode(String.self, forKey: .photo_200)
    }
}

// MARK: - Item

struct Item: Decodable {
    var source_id: Int
    var date: Double
    //var can_doubt_category: Bool
    //var can_set_category: Bool
    //var topic_id: Int?
    var post_type: String?
    var text: String
    //var marked_as_ads: Int
    var attachments: [Attachment]?
    var post_source: PostSource
    var comments: Comments
    var likes: Likes
    //var reposts: Reposts
    var views: Views?
    //var isFavorite: Bool
    //var donut: Donut
    //var shortTextRate: Double
    var post_id: Int
    var type: String
    //var carousel_offset
    //var signer_id: Int?
    //var copyright: Copyright?
    //var categoryAction: CategoryAction?
    let dateFormatter = DateFormatter()
    var dateText = ""
    
    enum CodingKeys: String, CodingKey {
        case source_id
        case date
        case attachments
        //case can_doubt_category
        //case can_set_category
        //case topic_id
        case post_type
        case text
        //case marked_as_ads
        case post_source
        case likes
        case views
        case post_id
        case type
        //case carousel_offset
        //case signer_id
        case comments
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.source_id = try container.decode(Int.self, forKey: .source_id)
        self.date = try container.decode(Double.self, forKey: .date)
        self.attachments = try container.decodeIfPresent ([Attachment]?.self, forKey: .attachments) as? [Attachment]
        //self.can_doubt_category = try container.decode(Bool.self, forKey: .can_doubt_category)
        //self.can_set_category = try container.decode(Bool.self, forKey: .can_set_category)
        //self.topic_id = try container.decode(Int.self, forKey: .topic_id)
        self.post_type = try container.decodeIfPresent(String.self, forKey: .post_type)
        self.text = try container.decode(String.self, forKey: .text)
        //self.marked_as_ads = try container.decode(Int.self, forKey: .marked_as_ads)
        self.post_source = try container.decode(PostSource.self, forKey: .post_source)
        self.likes = try container.decode(Likes.self, forKey: .likes)
        self.views = try container.decodeIfPresent(Views.self, forKey: .views)
        self.post_id = try container.decode(Int.self, forKey: .post_id)
        self.type = try container.decode(String.self, forKey: .type)
        self.comments = try container.decode(Comments.self, forKey: .comments)
        //self.carousel_offset = try container.decode(Int.self, forKey: .carousel_offset)
        //self.signer_id = try container.decode(Int.self, forKey: .signer_id)
        dateFormatter.dateFormat = "dd MMM в HH:mm"
        dateFormatter.timeZone = .current
        self.dateText = dateFormatter.string(from: Date(timeIntervalSince1970: date))
                
    }
    
}

// MARK: - Attachment

struct Attachment: Decodable {
    var type: String
    var photo: AttachmentPhoto?
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.photo = try container.decodeIfPresent(AttachmentPhoto.self, forKey: .photo)
    }
}


// MARK: - AttachmentPhoto

struct AttachmentPhoto: Decodable {
    var album_id: Int
    var date: Int
    var id: Int
    var owner_id: Int
    var has_tags: Bool
    var access_key: String?
    var post_id: Int?
    var sizes: [AttachPhotoSize]?
    var text: String
    var user_id: Int?
    //var lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case album_id
        case date
        case id
        case owner_id
        case has_tags
        case access_key
        //case post_id
        case sizes
        case text
        case user_id
        //case lat
        //case long
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.album_id = try container.decode(Int.self, forKey: .album_id)
        self.date = try container.decode(Int.self, forKey: .date)
        self.id = try container.decode(Int.self, forKey: .id)
        self.owner_id = try container.decode(Int.self, forKey: .owner_id)
        self.has_tags = try container.decode(Bool.self, forKey: .has_tags)
        self.access_key = try container.decodeIfPresent(String.self, forKey: .access_key)
        //self.post_id = try container.decode(Int.self, forKey: .post_id)
        self.sizes = try container.decode([AttachPhotoSize].self, forKey: .sizes)
        self.text = try container.decode(String.self, forKey: .text)
        self.user_id = try container.decodeIfPresent(Int.self, forKey: .user_id)
        //self.lat = try container.decode(Double.self, forKey: .lat)
        //self.long = try container.decode(Double.self, forKey: .long)

    }
}

// MARK: - AttachPhotoSize

struct AttachPhotoSize: Decodable {
    //var src: String? = ""
    var width: Int
    var height: Int
    var type: String
    //var file_size: Int?
    var url: String
    //var with_padding: Int?
    var aspectRatio: CGFloat { return CGFloat(height)/CGFloat(width) }

    enum CodingKeys: String, CodingKey {
        //case src
        case width
        case height
        case type
       //case file_size
        case url
        //case with_padding
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //self.src = try container.decode(String.self, forKey: .src)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.type = try container.decode(String.self, forKey: .type)
        //self.file_size = try container.decode(Int.self, forKey: .file_size)
        self.url = try container.decode(String.self, forKey: .url)
        //self.with_padding = try container.decode(Int.self, forKey: .with_padding)
    }
}


// MARK: - PostSource

struct PostSource: Decodable {
    var type: String = ""
    //var platform: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        //case platform
    }
       
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.type = try container.decode(String.self, forKey: .type)
            //self.platform = try container.decode(String.self, forKey: .platform)
        }
    }



// MARK: - Likes
struct Likes: Decodable {
    var count: Int = 0
    var user_likes: Int = 0
    var can_like: Int = 0
    var can_publish: Int = 0

    enum CodingKeys: String, CodingKey {
        case count
        case user_likes
        case can_like
        case can_publish
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.user_likes = try container.decode(Int.self, forKey: .user_likes)
        self.can_like = try container.decode(Int.self, forKey: .can_like)
        self.can_publish = try container.decode(Int.self, forKey: .can_publish)
        }
}

// MARK: - Views
struct Views: Decodable {
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
    }
}


// MARK: - Comments

struct Comments: Decodable {
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case count
    }
       
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.count = try container.decode(Int.self, forKey: .count)
            //self.platform = try container.decode(String.self, forKey: .platform)
        }
    }

// MARK: - Profile

struct Profile: Decodable {
    var first_name: String
    var id: Int
    var last_name: String
    //var canAccessClosed, isClosed: Bool?
    //var sex: Int
    // screen_name: String?
    var photo_50: String
    var photo_100: String
    //var onlineInfo: OnlineInfo
    //var online: Int
    //var onlineMobile, onlineApp: Int?
    //var deactivated: String?

    enum CodingKeys: String, CodingKey {
        case first_name
        case id
        case last_name
        //case screen_name
        case photo_50
        case photo_100
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.first_name = try container.decode(String.self, forKey: .first_name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.last_name = try container.decode(String.self, forKey: .last_name)
        //self.screen_name = try container.decode(String.self, forKey: .screen_name)
        self.photo_50 = try container.decode(String.self, forKey: .photo_50)
        self.photo_100 = try container.decode(String.self, forKey: .photo_100)
    }    
}
