//
//  NetworkTableViewController.m
//  LYProjectDemo
//
//  Created by 李龙跃 on 2018/12/25.
//  Copyright © 2018 Longyue Li. All rights reserved.
//

#import "NetworkTableViewController.h"

@interface NetworkTableViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSURLConnectionDownloadDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;


@property (nonatomic, strong) NSURLSession *session;

@end

@implementation NetworkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"网络编程";
    
    self.dataArray = [[NSMutableArray alloc] init];
    [self loadDataArray];
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(applicationDidEnterBackground:)
//                                                 name:UIApplicationDidEnterBackgroundNotification
//                                               object:nil];
}

- (void)loadDataArray {
    [self.dataArray addObject:@"NSURLConnection delegate方法"];
    [self.dataArray addObject:@"NSURLConnection 同步方法"];
    [self.dataArray addObject:@"NSURLConnection 异步方法"];
    
    [self.dataArray addObject:@"NSURLSession 简单会话"];
    [self.dataArray addObject:@"NSURLSession 默认会话"];
    [self.dataArray addObject:@"NSURLSession 短暂会话"];
    [self.dataArray addObject:@"NSURLSession 后台会话"];
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
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@",dict);
        }
            break;
        case 2: {
            //异步请求
            NSURL *url = [NSURL URLWithString:@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSLog(@"%@",dict);
                NSLog(@"%@",[NSThread currentThread]);
            }];
        }
            break;
        case 3: {
            //实现简单NSURLSession会话，方法是异步执行
            NSURL *url = [NSURL URLWithString:@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSLog(@"%@",dict);
                NSLog(@"%@",[NSThread currentThread]);
            }];
            [task resume];
        }
            break;
        case 4: {
            //实现默认会话
            NSURL *url = [NSURL URLWithString:@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            //第一种初始化方法
//            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            //第二种初始化方法 可以觉得是否实现代理 nil为不实现 queue:主队列中实现
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSLog(@"%@",dict);
                NSLog(@"%@",[NSThread currentThread]);
            }];
            [task resume];
            
        }
            break;
        case 5: {
            //实现短暂会话 基本和默认会话使用相同 区别没研究
            NSURL *url = [NSURL URLWithString:@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            //第一种初始化方法
                        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            //第二种初始化方法 可以觉得是否实现代理 nil为不实现 queue:主队列中实现
//            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSLog(@"%@",dict);
                NSLog(@"%@",[NSThread currentThread]);
            }];
            [task resume];
        }
            break;
        case 6: {
            //实现后台会话
            //TO DO:还不是特别懂，后面再研究
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
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSLog(@"%@",dict);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"请求完成~");
}


#pragma mark - NSURLSessionDelegate


@end
