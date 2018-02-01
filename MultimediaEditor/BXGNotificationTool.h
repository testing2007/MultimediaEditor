//
//  BXGNotificationTool.h
//  Boxuegu
//
//  Created by HM on 2017/4/18.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGNetWorkTool.h"

@protocol BXGNotificationDelegate <NSObject>

@optional

- (void)catchRechbility:(BXGReachabilityStatus)status;
- (void)catchServerError; // 即将移除

@end

@interface BXGNotificationTool : NSObject <BXGNetWorkToolDelegate>

+ (instancetype)share;

/**
 网络状态变化通知
 */

+ (void)addObserverForReachability:(NSObject<BXGNotificationDelegate> *)observer;
+ (void)postNotificationForReachability:(BXGReachabilityStatus)state;

#pragma mark - 通知网络错误
+ (void)postNotificationForServerError;
+ (void)addObserverForServerError:(NSObject<BXGNotificationDelegate> *)observer;

/// 移除监听
+ (void)removeObserver:(id)obj;

@end
