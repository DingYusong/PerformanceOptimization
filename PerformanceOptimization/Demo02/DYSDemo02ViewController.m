//
//  DYSDemo02ViewController.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/7.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo02ViewController.h"
#import "DYSDemo02DrawView.h"
#import "DYSDemo02DrawView2.h"

@interface DYSDemo02ViewController ()

@property (nonatomic, strong) DYSDemo02DrawView *drawView;

@end

@implementation DYSDemo02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
//    DYSDemo02DrawView *view = [DYSDemo02DrawView new];
    DYSDemo02DrawView2 *view = [DYSDemo02DrawView2 new];
    
    
    view.frame = self.view.bounds;
    [self.view addSubview:view];

//    self.drawView = view;
}

//-(void)updateViewConstraints {
//    self.drawView.frame = self.view.bounds;
//}

- (void)viewWillLayoutSubviews {
    self.drawView.frame = self.view.bounds;
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
