//
//  ThreadTableViewController.m
//  LYProjectDemo
//
//  Created by 李龙跃 on 2018/12/28.
//  Copyright © 2018 Longyue Li. All rights reserved.
//

#import "ThreadTableViewController.h"

@interface ThreadTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ThreadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc] init];
    [self loadDataArray];
}

- (void)loadDataArray {
    [self.dataArray addObject:@"GCD"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"threadcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            //创建串行队列：
            dispatch_queue_t syncqueue = dispatch_queue_create("robertlee.testqueue", DISPATCH_QUEUE_SERIAL);
            
            //创建并行队列
            dispatch_queue_t casyncqueue = dispatch_queue_create("robertleel.testqueue", DISPATCH_QUEUE_CONCURRENT);
            
            //全局并发队列
            dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            //获取主队列
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            
            //提交任务
            dispatch_sync(dispatch_get_main_queue(), ^{
                //
            });
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                //code
                
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    //code
                });
            });
            
            //单次执行方法
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                //code
            });
            
            //多次执行方法
//            dispatch_apply(5, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t) {
//                //
//            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //
            });
            
            
        }
            break;
            
        default:
            break;
    }
}


@end
