//
//  ViewController.m
//  LYProjectDemo
//
//  Created by 李龙跃 on 2018/12/13.
//  Copyright © 2018 Longyue Li. All rights reserved.
//

#import "ViewController.h"
#import <YYCache/YYCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *url = @"https://www.baidu.com";
//
//    NSString *key = @"cacheKey";
//
//    //初始化
//    YYCache *cache = [YYCache cacheWithName:@"cacheTest"];
//    //同步方法
//    [cache setObject:url forKey:key];
//    //异步方法
//    [cache setObject:url forKey:key withBlock:^{
//    }];
//    //判断缓存中，是否存在key值key得value
//    BOOL result = [cache containsObjectForKey:key];
//    //判断缓存中，是否存在key值key得value,bolck回调
//   [cache containsObjectForKey:key withBlock:^(NSString * _Nonnull key, BOOL contains) {
//
//    }];
//    //根据key移除缓存
//    [cache removeObjectForKey:key];
    //...还有带block回调的移除f缓存方法，还有移除所有缓存，带进度和结束block的方法，在这里就不一一介绍了。
    
    
    NSURL *url = [NSURL URLWithString:@"https:www.github.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
    }];
    NSLog(@"data:%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    NSLog(@"error:%@",error);
    NSLog(@"response:%@",response);
    
}


@end
