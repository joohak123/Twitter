//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Joohak Lee on 9/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var favorited:Bool = false
    var tweetId: Int = -1
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }
        
    }
    
    func setFavorite(_ isFavorite:Bool){
        favorited = isFavorite
        if(favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)//swap image icon
        }
        else{
            favButton.setImage(UIImage(named:"favor-icon"), for:UIControl.State.normal)
        }
    }
    
    var retweeted:Bool = false
    
    @IBAction func retweet(_ sender: Any) {
        let retweeted = !retweeted
        if(retweeted){
            TwitterAPICaller.client?.retweetTweet(tweetId: tweetId, success: {
                self.setRetweet(true)
            }, failure: { (error) in
                print("retweet did not succeed: \(error)")
            })
        }else{
            TwitterAPICaller.client?.unretweetTweet(tweetId: tweetId, success: {
                self.setRetweet(false)
            }, failure: { (error) in
                print("retweet did not succeed: \(error)")
            })
        }
    }
    
    func setRetweet(_ isRetweet:Bool){
        retweeted = isRetweet
        if(retweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            //retweetButton.isEnabled = false

        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            //retweetButton.isEnabled = true

        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
