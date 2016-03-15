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
    
    var postData: PostData?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 表示されるときに呼ばれるメソッドをオーバーライドしてデータをUIに反映する
    override func layoutSubviews() {
        
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
        
        super.layoutSubviews()
    }
    
}
