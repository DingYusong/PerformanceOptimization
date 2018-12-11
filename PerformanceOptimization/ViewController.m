//
//  ViewController.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/7.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray *dataSourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"性能调试";
    self.dataSourceArray = @[
                             @{
                                 @"title":@"性能调优Demo",
                                 @"page":@"DYSDemo01ViewController"
                                 },
                             @{
                                 @"title":@"Core Graphics-矢量图形/CAShapeLayer/脏矩形",
                                 @"page":@"DYSDemo02ViewController"
                                 },
                             @{
                                 @"title":@"图像IO-无优化",
                                 @"page":@"DYSDemo03ViewController"
                                 },
                             @{
                                 @"title":@"图像IO-加载优化",
                                 @"page":@"DYSDemo04ViewController"
                                 },
                             @{
                                 @"title":@"图像IO-加载优化，解压优化",
                                 @"page":@"DYSDemo05ViewController"
                                 },
                             @{
                                 @"title":@"图像IO-加载优化，解压优化，缓存优化",
                                 @"page":@"DYSDemo06ViewController"
                                 },
                             @{
                                 @"title":@"图层性能-隐式绘制/离屏渲染-圆角",
                                 @"page":@"DYSDemo07ViewController"
                                 },
                             @{
                                 @"title":@"图层性能-减少图层数量",
                                 @"page":@"DYSDemo08ViewController"
                                 },
                             @{
                                 @"title":@"图层性能-减少图层数量，部分实例化优化",
                                 @"page":@"DYSDemo09ViewController"
                                 },
                             ];
    self.tableView.rowHeight = 50;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    
    NSDictionary *dict = [self.dataSourceArray objectAtIndex:(self.dataSourceArray.count - indexPath.row - 1)];
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.textLabel.numberOfLines = 0;
//    [cell.textLabel sizeToFit];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.dataSourceArray objectAtIndex:(self.dataSourceArray.count - indexPath.row - 1)];
    NSString *classString = [dict objectForKey:@"page"];
    UIViewController *vc = [NSClassFromString(classString) new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
