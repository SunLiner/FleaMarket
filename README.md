## 项目blog地址
<a href="http://www.jianshu.com/p/2b03d19f4acd">简书blog地址</a>

## 效果图
![咸鱼新特性](http://upload-images.jianshu.io/upload_images/1038348-8aca5e5b57b66949.gif?imageMogr2/auto-orient/strip)

## 用法
OC用法:
```objc
#import "NewFeatureViewController.h"
```

```objc
NewFeatureViewController *newFeatureVC = [[NewFeatureViewController alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        [array addObject:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"guide%d",i] ofType:@"mp4"]];
    }
    // 1.设置本地视频路径数组
    newFeatureVC.guideMoviePathArr = array;
    // 2.设置封面图片数组
    newFeatureVC.guideImagesArr = @[@"guide0", @"guide1", @"guide2", @"guide3"];
    // 3.设置最后一个视频播放完成之后的block
    [newFeatureVC setLastOnePlayFinished:^{
        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootNav;
    }];
    self.window.rootViewController = newFeatureVC;
```

Swift用法

```swift
 // 配置本地视频路径和视频的封面图片
var paths = [String]()
var images = [UIImage]()
for i in 0..<4 {
    paths.append(NSBundle.mainBundle().pathForResource("guide\(i)", ofType: "mp4")!)
    images.append(UIImage(named: "guide\(i)")!)
}
// 设置rootViewController为新特性控制器
window?.rootViewController = NewFeatureViewController(images: images, moviePaths: paths, playFinished: { [unowned self] in
    self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
})
```
