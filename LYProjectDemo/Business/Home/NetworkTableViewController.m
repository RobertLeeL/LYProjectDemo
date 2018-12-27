//
//  NetworkTableViewController.m
//  LYProjectDemo
//
//  Created by 李龙跃 on 2018/12/25.
//  Copyright © 2018 Longyue Li. All rights reserved.
//

#import "NetworkTableViewController.h"
#import <AFNetworking.h>

@interface NetworkTableViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSURLConnectionDownloadDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate,NSURLSessionStreamDelegate>

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
    
    [self.dataArray addObject:@"NSURLSession NSURLSessionDownloadDelegate"];
    
    [self.dataArray addObject:@"AFNetworking"];
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
        case 7: {
            //NSURLSessionDelegate
            NSURL *url = [NSURL URLWithString:@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            //第一种初始化方法
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//            NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
            NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
            [task resume];
        }
            break;
        case 8: {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                //最大请求并发任务数
                manager.operationQueue.maxConcurrentOperationCount = 5;
                
                // 请求格式
                // AFHTTPRequestSerializer            二进制格式
                // AFJSONRequestSerializer            JSON
                // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
                
                manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
                
                // 超时时间
                manager.requestSerializer.timeoutInterval = 30.0f;
                // 设置请求头
                [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
                // 设置接收的Content-Type
                manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
                
                // 返回格式
                // AFHTTPResponseSerializer           二进制格式
                // AFJSONResponseSerializer           JSON
                // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
                // AFXMLDocumentResponseSerializer (Mac OS X)
                // AFPropertyListResponseSerializer   PList
                // AFImageResponseSerializer          Image
                // AFCompoundResponseSerializer       组合
                
                manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
                //设置返回C的ontent-type
                manager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
                
                //创建请求地址
                NSString *url=@"https://www.tking.cn/showapi/mobile/pub/site/1002/active_show?isSupportSession=1&length=10&locationCityOID=1101&offset=0&seq=desc&siteCityOID=1101&sorting=weight&src=ios&type=6&ver=4.1.0";
                //AFN管理者调用get请求方法
                [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    //返回请求返回进度
                    NSLog(@"downloadProgress-->%@",downloadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //请求成功返回数据 根据responseSerializer 返回不同的数据格式
                    NSLog(@"responseObject-->%@",responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    //请求失败
                    NSLog(@"error-->%@",error);
                }];
        }
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

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    
}

// 研究作用
//- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//
//}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"1234");
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSLog(@"1234");
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask {
    NSLog(@"1234");
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSLog(@"%@",dict);
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    NSLog(@"1234");
}


#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willBeginDelayedRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLSessionDelayedRequestDisposition disposition, NSURLRequest * _Nullable newRequest))completionHandler {
    NSLog(@"123");
}

- (void)URLSession:(NSURLSession *)session taskIsWaitingForConnectivity:(NSURLSessionTask *)task {
    NSLog(@"1234");
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    NSLog(@"12345");
}

//研究作用
//- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
// completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//
//}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler {
    
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics {
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"NSURLSessionDownloadDelegate: %@",location);
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"NSURLSessionDownloadDelegate: %lld",totalBytesExpectedToWrite);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"NSURLSessionDownloadDelegate: %lld",expectedTotalBytes);
}

#pragma mark - NSURLSessionStreamDelegate

- (void)URLSession:(NSURLSession *)session readClosedForStreamTask:(NSURLSessionStreamTask *)streamTask {
    
}


- (void)URLSession:(NSURLSession *)session writeClosedForStreamTask:(NSURLSessionStreamTask *)streamTask {
    
}

- (void)URLSession:(NSURLSession *)session betterRouteDiscoveredForStreamTask:(NSURLSessionStreamTask *)streamTask {
    
}


- (void)URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask
didBecomeInputStream:(NSInputStream *)inputStream
      outputStream:(NSOutputStream *)outputStream {
    
}

@end
