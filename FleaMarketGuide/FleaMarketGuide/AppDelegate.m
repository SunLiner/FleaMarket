//
//  AppDelegate.m
//  FleaMarketGuide
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [self setupNewFeature];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (NewFeatureViewController *)setupNewFeature
{
    NewFeatureViewController *newFeatureVC = [[NewFeatureViewController alloc] init];
    // 设置本地视频路径数组
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        [array addObject:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"guide%d",i] ofType:@"mp4"]];
    }
    newFeatureVC.guideMoviePathArr = array;
    // 设置封面图片数组
    newFeatureVC.guideImagesArr = @[@"guide0", @"guide1", @"guide2", @"guide3"];
    // 设置最后一个视频播放完成之后的block
    [newFeatureVC setLastOnePlayFinished:^{
        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootNav;
    }];
    return newFeatureVC;
}

@end
