//
//  DYSDemo08ViewController.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/11.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo08ViewController.h"

#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500

//当WIDTH，HEIGHT，DEPTHs都是100的时候直接卡死了。

@interface DYSDemo08ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DYSDemo08ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize = CGSizeMake((WIDTH-1)*SPACING, (HEIGHT-1)*SPACING);

    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;

    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;

                [self.scrollView.layer addSublayer:layer];
            }
        }
    }
    //log
    NSLog(@"displayed: %i", DEPTH*HEIGHT*WIDTH);
    
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
