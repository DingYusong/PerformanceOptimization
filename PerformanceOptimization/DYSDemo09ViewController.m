//
//  DYSDemo09ViewController.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/11.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo09ViewController.h"
#define WIDTH 100
#define HEIGHT 100
#define DEPTH 10

#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500

#define PERSPECTIVE(z) (float)CAMERA_DISTANCE/(z + CAMERA_DISTANCE)

@interface DYSDemo09ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DYSDemo09ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.scrollView.contentSize = CGSizeMake((WIDTH-1)*SPACING, (HEIGHT-1)*SPACING);
//
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1.0/CAMERA_DISTANCE;
//    self.scrollView.layer.sublayerTransform = transform;
    
    
    
    //set content size
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING,
                                             (HEIGHT - 1)*SPACING);
    
    //set up perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;

//
//    for (int z = DEPTH - 1; z >= 0; z--) {
//        for (int y = 0; y < HEIGHT; y++) {
//            for (int x = 0; x < WIDTH; x++) {
//                CALayer *layer = [CALayer layer];
//                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
//                layer.position = CGPointMake(x*SPACING, y*SPACING);
//                layer.zPosition = -z*SPACING;
//                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
//
//                [self.scrollView.layer addSublayer:layer];
//            }
//        }
//    }
//    //log
//    NSLog(@"displayed: %i", DEPTH*HEIGHT*WIDTH);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self dys_updateLayers];
}

- (void)viewDidLayoutSubviews {
    [self dys_updateLayers];
}



- (void)dys_updateLayers {
    //calculate clipping bounds
    CGRect bounds = self.scrollView.bounds;
    bounds.origin = self.scrollView.contentOffset;
    bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2);
    
    //create layers
    NSMutableArray *visibleLayers = [NSMutableArray array];
    for (int z = DEPTH - 1; z >= 0; z--)
    {
        //increase bounds size to compensate for perspective
        CGRect adjusted = bounds;
        adjusted.size.width /= PERSPECTIVE(z*SPACING);
        adjusted.size.height /= PERSPECTIVE(z*SPACING);
        adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2;
        adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2;
        
        for (int y = 0; y < HEIGHT; y++)
        {
            //check if vertically outside visible rect
            if (y*SPACING < adjusted.origin.y ||
                y*SPACING >= adjusted.origin.y + adjusted.size.height)
            {
                continue;
            }
            
            for (int x = 0; x < WIDTH; x++)
            {
                //check if horizontally outside visible rect
                if (x*SPACING < adjusted.origin.x ||
                    x*SPACING >= adjusted.origin.x + adjusted.size.width)
                {
                    continue;
                }
                
                //create layer
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                
                //set background color
                layer.backgroundColor = [UIColor colorWithWhite:1 - z*(1.0/DEPTH)
                                                          alpha:1.0].CGColor;
                //attach to scroll view
                [visibleLayers addObject:layer];
            }
        }
    }
    
    //update layers
    self.scrollView.layer.sublayers = visibleLayers;
    
    //log
    NSLog(@"displayed: %lu/%i", (unsigned long)[visibleLayers count], DEPTH*HEIGHT*WIDTH);
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
