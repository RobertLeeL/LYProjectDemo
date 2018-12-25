//
//  NetworkTableViewController.m
//  LYProjectDemo
//
//  Created by 李龙跃 on 2018/12/25.
//  Copyright © 2018 Longyue Li. All rights reserved.
//

#import "NetworkTableViewController.h"

@interface NetworkTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NetworkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"网络编程";
    
    self.dataArray = [[NSMutableArray alloc] init];
    [self loadDataArray];
    
}

- (void)loadDataArray {
    [self.dataArray addObject:@"NSURLConnection"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"netWorkcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            NSLog(@"123");
        }
            break;
            
        default:
            break;
    }
}

@end
