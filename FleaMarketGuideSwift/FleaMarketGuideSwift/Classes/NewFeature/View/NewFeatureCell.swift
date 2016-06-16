//
//  NewFeatureCell.swift
//  FleaMarketGuideSwift
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

import UIKit
import MediaPlayer

let PlayFinishedNotify = "PlayFinishedNotify"

class NewFeatureCell: UICollectionViewCell {
    var coverImage : UIImage?
    {
        didSet{
            if let _ = coverImage {
               imageView.image = coverImage
            }
            
        }
    }
    var moviePath : String?{
        didSet{
            if let iPath = moviePath {
                moviePlayer.contentURL = NSURL(fileURLWithPath: iPath, isDirectory: false)
                moviePlayer.prepareToPlay()
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(moviePlayer.view)
        moviePlayer.view.addSubview(imageView)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame:self.moviePlayer.view.bounds)
        return imageView
    }()
    
    private lazy var moviePlayer : MPMoviePlayerController = {
        let player = MPMoviePlayerController()
        player.view.frame = self.contentView.bounds
        // 设置自动播放
        player.shouldAutoplay = true
        // 设置源类型
        player.movieSourceType = .File
        // 取消下面的控制视图: 快进/暂停等...
        player.controlStyle = .None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewFeatureCell.playerDisplayChange), name: MPMoviePlayerReadyForDisplayDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewFeatureCell.playFinished), name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        return player
 
    }()
    
    // MARK: - private method
    
    func playerDisplayChange()
    {
        if moviePlayer.readyForDisplay {
            moviePlayer.backgroundView.addSubview(imageView)
        }
    }
    
    func playFinished()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(PlayFinishedNotify, object: nil)
    }

    
}
