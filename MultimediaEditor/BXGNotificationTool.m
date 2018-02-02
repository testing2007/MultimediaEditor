//
//  BXGNotificationTool.m
//  Boxuegu
//
//  Created by RW on 2017/4/18.
//  Copyright © 2017年 itcast. All rights reserved.
//
#import "BXGNotificationTool.h"

// 用户网路检测通知名
#define kBXGNotiNameReachbility @"kBXGNotiNameReachbility"
#define kBXGUserInfoReachbility @"kBXGUserInfoReachbilityState"

// 服务器异常 /
#define kBXGNotiServerError @"kBXGNotiServerError"
#define kBXGNotiUserInfokNotiServerError @"kBXGNotiUserInfokNotiServerError"

@interface BXGNotificationTool() <BXGNetworkToolDelegate>

@end

@implementation BXGNotificationTool

static BXGNotificationTool *instance;
+ (instancetype)share {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        instance = [BXGNotificationTool new];
    });
    return instance;
}


+ (void)postNotificationForReachability:(BXGReachabilityStatus)state {
    
    NSDictionary *dict = @{kBXGUserInfoReachbility: @(state)};
    [[NSNotificationCenter defaultCenter] postNotificationName:kBXGNotiNameReachbility object:nil userInfo:dict];
}

+ (void)addObserverForReachability:(NSObject<BXGNotificationDelegate> *)observer; {

    __weak NSObject<BXGNotificationDelegate> *weakObserver = observer;
    
    [[NSNotificationCenter defaultCenter] addObserverForName: kBXGNotiNameReachbility object:nil queue:[NSOperationQueue mainQueue]  usingBlock:^(NSNotification * _Nonnull noti) {
        
        if([weakObserver respondsToSelector:@selector(catchRechbility:)]){
            NSNumber *state = [noti.userInfo objectForKey:kBXGUserInfoReachbility];
            [weakObserver catchRechbility: [state integerValue]];
        }
    }];
}

#pragma mark - remove

+ (void)removeObserver:(id)obj {
    
    [[NSNotificationCenter defaultCenter] removeObserver:obj];

}

#pragma mark - 服务器异常 / Token过期通知

+ (void)postNotificationForServerError {

    [[NSNotificationCenter defaultCenter] postNotificationName:kBXGNotiServerError object:nil userInfo:nil];
}

+ (void)addObserverForServerError:(NSObject<BXGNotificationDelegate> *)observer {
    
    __weak NSObject<BXGNotificationDelegate> *weakObserver = observer;
    
    [[NSNotificationCenter defaultCenter] addObserverForName: kBXGNotiServerError object:nil queue:[NSOperationQueue mainQueue]  usingBlock:^(NSNotification * _Nonnull noti) {
        
        if([weakObserver respondsToSelector:@selector(catchServerError)]){
            
            [weakObserver catchServerError];
        }
    }];
}

#pragma mark - Network Toll delegate

- (void)networkServerError {

    [[NSNotificationCenter defaultCenter] postNotificationName:kBXGNotiServerError object:nil userInfo:nil];
}

@end
