//
//  DYSDemo07ViewController.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/11.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo07ViewController.h"

@interface DYSDemo07ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *layerView2;

@end

@implementation DYSDemo07ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self dys_layerRadius];
    [self dys_imageRadius];
}


- (void)dys_layerRadius {
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.layerView.bounds cornerRadius:15];
    //    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.path = path.CGPath;
    
    layer.frame = self.layerView.bounds;
    [self.layerView.layer addSublayer:layer];
    self.layerView.backgroundColor = [UIColor clearColor];
}

- (void)dys_imageRadius {
    //create layer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.0, 0.0);
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    blueLayer.contents = (__bridge id)[UIImage imageNamed:@"Rounded.png"].CGImage;
    
    //add it to our view
    blueLayer.frame = self.layerView2.bounds;
    [self.layerView2.layer addSublayer:blueLayer];
    self.layerView2.backgroundColor = [UIColor clearColor];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
