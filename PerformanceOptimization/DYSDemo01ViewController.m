//
//  DYSDemo01ViewController.m
//  PerformanceOptimization
//
//  Created by 丁玉松 on 2018/12/7.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo01ViewController.h"

@interface DYSDemo01ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@property (nonatomic, copy) NSArray *dataSourceArray;

@end

@implementation DYSDemo01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 1000; i++) {
        [array addObject:@{
                           @"avatar":[self dys_randomAvator],
                           @"name":[self dys_randomName]
                           }];
    }
    self.dataSourceArray = array;
    [self.tableVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
}

- (NSString *)dys_randomAvator {
    NSArray *avatarArray = @[@"beauty",@"baby",@"dog"];
    NSInteger i = arc4random()%avatarArray.count;
    return avatarArray[i];
}

- (NSString *)dys_randomName {
    NSArray *nameArray = @[@"111111111111111",@"2222222222222",@"33333333333333"];
    NSInteger i = arc4random()%nameArray.count;
    return nameArray[i];
}



#pragma mark -  tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    NSDictionary *item = [self.dataSourceArray objectAtIndex:indexPath.row];

    NSString *name = [item objectForKey:@"name"];
    NSString *avatar = [item objectForKey:@"avatar"];
    NSString *avatarPath = [[NSBundle mainBundle] pathForResource:avatar ofType:@"png"];
    
    cell.textLabel.text = name;

    
    //优化点1.加载方式改为共享内存，帧频大大提高
    //    cell.imageView.image = [UIImage imageWithContentsOfFile:avatarPath];
    cell.imageView.image = [UIImage imageNamed:avatar];
    
    //优化点2.阴影会产生图层混合，降低帧频，去掉阴影效果或者禁用栅格化都会显著增加帧频
    //set image shadow
    cell.imageView.layer.shadowOffset = CGSizeMake(0, 5);
    cell.imageView.layer.shadowOpacity = 0.75;
    cell.clipsToBounds = YES;
    
    //set text shadow
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.layer.shadowOffset = CGSizeMake(0, 2);
    cell.textLabel.layer.shadowOpacity = 0.5;

    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;//不开这个很模糊呀
    
    return cell;
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
