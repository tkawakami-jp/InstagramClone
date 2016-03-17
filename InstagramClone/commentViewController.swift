//
//  commentViewController.swift
//  InstagramClone
//
//  Created by Takahiro.Kawakami on 2016/03/16.
//  Copyright © 2016年 Takahiro.Kawakami. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var firebaseRef:Firebase!
    var postData: PostData!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func handleCommentButton(sender: AnyObject) {
        
        // Firebaseに保存するデータの準備
        let ud = NSUserDefaults.standardUserDefaults()
        let commentName = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        let commentText = textView.text
        let commentTime = NSDate.timeIntervalSinceReferenceDate()
        let comments = ["commentName":commentName, "commentText":commentText, "commentTime": commentTime]
        
        // 辞書を作成してFirebaseに保存する
        let postRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.PostPATH)
        postRef.childByAppendingPath(postData.id).childByAppendingPath("comments").childByAutoId().setValue(comments)
        
        // 全てのモーダルを閉じる
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func handleCancelButton(sender: AnyObject) {
        // 画面を閉じる
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.borderWidth = 0.5;
        textView.layer.cornerRadius = 6;
        textView.layer.borderColor = UIColor.blackColor().CGColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
