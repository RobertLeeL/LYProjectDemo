//
//  NetworkTableViewController.m
//  LYProjectDemo
//
//  Created by 李龙跃 on 2018/12/25.
//  Copyright © 2018 Longyue Li. All rights reserved.
//

#import "NetworkTableViewController.h"

@interface NetworkTableViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSURLConnectionDownloadDelegate>

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
    [self.dataArray addObject:@"NSURLConnection delegate方法"];
    [self.dataArray addObject:@"NSURLConnection 同步方法"];
    [self.dataArray addObject:@"NSURLConnection 异步方法"];
    
    [self.dataArray addObject:@"NSURLSession"];
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
//            https://robertleel.github.io/2018/12/24/iOS%E5%A4%9A%E7%BA%BF%E7%A8%8B%E5%BC%80%E5%8F%91-NSOperation/#more
            
            //代理方法
            NSURL *url = [NSURL URLWithString:@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0"];
            NSURLRequest *requst = [[NSURLRequest alloc]initWithURL:url];
            //第一种 方法
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:requst delegate:self];
            
            //第二种方法
//            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:requst delegate:self startImmediately:YES];
            
            
            //第三种方法
//            NSURLConnection *connction = [NSURLConnection connectionWithRequest:requst delegate:self];
        }
            break;
        case 1: {
            //同步请求
            NSURL *url = [NSURL URLWithString:@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSError *error = nil;
            NSURLResponse *response = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSLog(@"%@",data);
        }
            break;
        case 2: {
            //异步请求
            NSURL *url = [NSURL URLWithString:@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                NSLog(@"%@",data);
                NSLog(@"%@",[NSThread currentThread]);
            }];
        }
            break;
        default:
            break;
    }
}


#pragma mark -NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //等我的tools开发完成 再data转json
    NSLog(@"%@",data);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"请求完成~");
}

@end
