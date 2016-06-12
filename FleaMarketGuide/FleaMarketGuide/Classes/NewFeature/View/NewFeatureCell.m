//
//  NewFeatureCell.m
//  FleaMarketGuide
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "NewFeatureCell.h"
#import <MediaPlayer/MediaPlayer.h>



@interface NewFeatureCell()
/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;
/** movie播放器 */
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@end

@implementation NewFeatureCell

#pragma mark - lazy loading

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.moviePlayer.view.bounds];
        [self.moviePlayer.view addSubview:imageV];
        _imageView = imageV;
    }
    return _imageView;
}

- (MPMoviePlayerController *)moviePlayer
{
    if (!_moviePlayer) {
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] init];
        [player.view setFrame:self.contentView.bounds];
        // 设置自动播放
        [player setShouldAutoplay:YES];
        // 设置源类型, 因为新特性一般都是播放本地的小视频, 所以设置源类型为File
        player.movieSourceType = MPMovieSourceTypeFile;
        // 取消下面的控制视图: 快进/暂停等...
        player.controlStyle = MPMovieControlStyleNone;
        [self.contentView addSubview:player.view];
        // 监听状态的改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStatus) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        _moviePlayer = player;
    }
    return _moviePlayer;
}

#pragma mark - private method

- (void)loadStatus
{
    // 将要自动播放
    if (self.moviePlayer.loadState == MPMovieLoadStatePlaythroughOK)
    {
        self.imageView.hidden = YES;
        
        [self.moviePlayer play];
    }
}

- (void)playFinished
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PlayFinishedNotify object:nil];
}

#pragma mark - setter

- (void)setMoviePath:(NSString *)moviePath
{
    _moviePath = [moviePath copy];
    
    // 停止之前的播放
    [self.moviePlayer stop];
    // 设置播放的路径
    self.moviePlayer.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    [self.moviePlayer prepareToPlay];
}


- (void)setStartImage:(UIImage *)startImage
{
    _startImage = startImage;
    self.imageView.image = startImage;
}

#pragma mark - lift circle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
