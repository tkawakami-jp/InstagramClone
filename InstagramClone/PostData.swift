//
//  PostData.swift
//  InstagramClone
//
//  Created by Takahiro.Kawakami on 2016/03/15.
//  Copyright © 2016年 Takahiro.Kawakami. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    
    init(snapshot: FDataSnapshot, myId: String) {
        id = snapshot.key
        
        imageString = snapshot.value.objectForKey("image") as? String
        image = UIImage(data: NSData.init(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        
        name = snapshot.value.objectForKey("name") as? String
        caption = snapshot.value.objectForKey("caption") as? String
        
        if let likes = snapshot.value.objectForKey("likes") as? [String] {
            self.likes = likes
        }
        
        for likeId in likes {
            if likeId == myId {
                isLiked = true
                break
            }
        }
        
        self.date = NSDate.init(timeIntervalSinceReferenceDate: snapshot.value.objectForKey("time") as! NSTimeInterval)
    }
}
