//
//  PostTableViewCell.swift
//  InstagramClone
//
//  Created by Takahiro.Kawakami on 2016/03/15.
//  Copyright © 2016年 Takahiro.Kawakami. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentText: UILabel!
    //@IBOutlet weak var commentText: UITextView!
    
    var postData: PostData?
    var flag: String?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 表示されるときに呼ばれるメソッドをオーバーライドしてデータをUIに反映する
    override func layoutSubviews() {
        
        if(flag != postData!.id){
        
        commentLabel.text = "0"
        commentText.text = ""
        commentText.layer.borderWidth = 0.5
        commentText.layer.cornerRadius = 4
        commentText.layer.borderColor = UIColor.grayColor().CGColor
        
        postImageView.image = postData!.image
        captionLabel.text = "\(postData!.name!) : \(postData!.caption!)"
        
        let likeNumber = postData!.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.init(localeIdentifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.stringFromDate(postData!.date!)
        dateLabel.text = dateString
        
        if postData!.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }
        
        if let commentNumber = postData!.commentJson {
            commentLabel.text = "\(commentNumber.count)"
        }
        
        if let json = postData!.commentJson {
            for (_, value) in json {
                commentText.text = commentText.text! + "\(value["commentName"]):\(value["commentText"])\n"
            }
        }
        
        flag = postData!.id
        
        super.layoutSubviews()
        
        }
    }
    
}
