//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Takahiro.Kawakami on 2016/03/14.
//  Copyright © 2016年 Takahiro.Kawakami. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    var firebaseRef: Firebase!
    
    // ログインボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleLoginButton(sender: AnyObject) {
        
        if let address = mailAddressTextField.text, let password = passwordTextField.text {
            
            // アドレスとパスワード名のいずれかでも入力されていない時はHUDを出して何もしない
            if address.characters.count == 0 || password.characters.count == 0 {
                SVProgressHUD.showErrorWithStatus("必要項目を入力して下さい")
                return
            }
            
            firebaseRef.authUser(address, password: password, withCompletionBlock: { error, authData in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("エラー")
                } else {
                    
                    // Firebaseからログインしたユーザの表示名を取得してNSUserDefaultsに保存する
                    let usersRef = self.firebaseRef.childByAppendingPath(CommonConst.UsersPATH)
                    let uidRef = usersRef.childByAppendingPath(authData.uid)
                    uidRef.observeSingleEventOfType(FEventType.Value, withBlock: { snapshot in
                        
                        if let displayName = snapshot.value.objectForKey("name") as? String {
                            self.setDisplayName(displayName)
                        }
                        
                        // 画面を閉じる
                        self.dismissViewControllerAnimated(true, completion: nil)})
                }
            })
        }
    }
    
    // アカウント作成ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCreateAcountButton(sender: AnyObject) {
        
        if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
        
            // アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
            if address.characters.count == 0 || password.characters.count == 0 || displayName.characters.count == 0 {
                SVProgressHUD.showErrorWithStatus("必要項目を入力して下さい")
                return
            }
                
            firebaseRef.createUser(address, password: password, withValueCompletionBlock: { error, result in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("エラー")
                } else {
                    // ユーザーを作成できたらそのままログインする
                    self.firebaseRef.authUser(address, password: password, withCompletionBlock:  { error, authData in
                        if error != nil {
                            SVProgressHUD.showErrorWithStatus("エラー")
                        } else {
                            // Firebaseに表示名を保存する
                            let usersRef = self.firebaseRef.childByAppendingPath(CommonConst.UsersPATH)
                            let data = ["name": displayName]
                            usersRef.childByAppendingPath("/\(authData.uid)").setValue(data)
                                
                            // NSUserDefaultsに表示名を保存する
                            self.setDisplayName(displayName)
                                
                            // 画面を閉じる
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                    })
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firebaseを初期化する
        firebaseRef = Firebase(url: CommonConst.FirebaseURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // NSUserDefaultsに表示名を保存する
    func setDisplayName(name: String) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setValue(name, forKey: CommonConst.DisplayNameKey)
        ud.synchronize()
    }
    
}
