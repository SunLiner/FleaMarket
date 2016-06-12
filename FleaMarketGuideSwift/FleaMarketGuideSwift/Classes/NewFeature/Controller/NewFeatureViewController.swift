//
//  NewFeatureViewController.swift
//  FleaMarketGuideSwift
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

import UIKit

let MS_Width = UIScreen.mainScreen().bounds.size.width
let MS_Height = UIScreen.mainScreen().bounds.size.height
let Key_Window = UIApplication.sharedApplication().keyWindow

private let reuseIdentifier = "NewFeatureCell"

class NewFeatureViewController: UICollectionViewController {
    
    var guideImages: [UIImage]
    
    var guideMoviePaths: [String]
    
    var lastOnePlayFinished: ()->()
    
    // MARK: - life circle
    
    /**
     构造方法
     
     - parameter images:       封面图片
     - parameter moviePaths:   视频地址
     - parameter playFinished: 最后一个视频播放完毕
     */
    init(images:[UIImage], moviePaths:[String], playFinished: ()->()) {
        guideImages = images
        guideMoviePaths = moviePaths
        lastOnePlayFinished = playFinished
        
        super.init(collectionViewLayout: ALinFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewFeatureViewController.finishedPlay), name: PlayFinishedNotify, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        pageControl.numberOfPages = guideMoviePaths.count ?? 0
        
    }
    
    deinit
    {
        pageControl.removeFromSuperview()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - private method
    
    private var isMovieFinished = false
    func finishedPlay() {
        isMovieFinished = true
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return guideMoviePaths.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
        
        cell.coverImage = guideImages[indexPath.item]
        
        cell.moviePath = guideMoviePaths[indexPath.item]
        
        isMovieFinished = false
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item ==  guideMoviePaths.count - 1 && isMovieFinished{
            lastOnePlayFinished()
        }
    }
    
    // MARK: UIScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / collectionView!.bounds.width + 0.5)
        pageControl.currentPage = page
    }

    // MARK : - 懒加载
    private lazy var pageControl : UIPageControl =
    {
        let width : CGFloat = 120.0
        let height : CGFloat = 30.0
        let x : CGFloat = (MS_Width - width) * 0.5;
        let y : CGFloat =  MS_Height - 30 - 20;
        let pageControl = UIPageControl(frame: CGRect(x: x, y: y, width: width, height: height))
            pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        Key_Window?.addSubview(pageControl)
        return pageControl;
    }()
    
    
}
