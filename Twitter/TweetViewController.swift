//
//  TweetViewController.swift
//  Twitter
//
//  Created by Joohak Lee on 10/3/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetCount: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange,
            replacementText text: String) -> Bool{
        let charLimit = 280
        let newText = NSString(string : tweetTextView.text!).replacingCharacters(in: range, with: text)
        
        return newText.count <= charLimit
    }
    func textViewDidChange(_ textView: UITextView) {
        tweetCount.text = "\(280 - tweetTextView.text.count)"
    }
}
