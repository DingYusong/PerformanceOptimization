//
//  DYSDemo04ViewController.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/10.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo04ViewController.h"

@interface DYSDemo04ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *imagePaths;

@end

@implementation DYSDemo04ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"Vacation Photos"];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = kCollectionScrollDirection;
    self.collectionView.collectionViewLayout = layout;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagePaths.count*100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSInteger imageTag = 99;
    UIImageView *imageView = [cell viewWithTag:imageTag];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        imageView.tag = imageTag;
        [cell addSubview:imageView];
    }
    //图片-加载-耗时
    //    imageView.image = [UIImage imageWithContentsOfFile:[self.imagePaths objectAtIndex:indexPath.row%11]];
    
//    优化1：加载-耗时优化 不卡主线程了，但是CPU的使用率同样没有下降
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image =  [UIImage imageWithContentsOfFile:[self.imagePaths objectAtIndex:indexPath.row%11]];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        });
    
    //优化2：解压耗时优化 强制解压提前渲染图片 可以感受得到相当的顺滑
//    CGRect imageBounds = imageView.bounds;//异步线程里不可访问UIView.bounds
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImage *image =  [UIImage imageWithContentsOfFile:[self.imagePaths objectAtIndex:indexPath.row%11]];
//        //        UIGraphicsBeginImageContext(imageView.bounds.size);
//        UIGraphicsBeginImageContextWithOptions(imageBounds.size, YES, 0);
//        [image drawInRect:imageBounds];
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            imageView.image = image;
//        });
//    });
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return kCollectionCellSize;
}

@end
