//
//  BXGNetwork.h
//  Boxuegu
//
//  Created by RenyingWu on 2017/12/5.
//  Copyright © 2017年 itcast. All rights reserved.
//

#ifndef BXGNetwork_h
#define BXGNetwork_h

#import "BXGLogMonitor.h"
#import "BXGNetworkParser.h"

#define kBaiduBaseURL @"http://api.fanyi.baidu.com"
#define kMainBaseUrlString @""

//
//#ifdef NETWORK_LOG_ON
/*
#define RWNetworkLog(format, ...) \
do {printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]); \
NSString *strContent = [NSString stringWithFormat:"[%@] %@ [第%d行] %@\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__]] ];
}while(0);

 do { \
 printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]); \
 NSString *strContent = [NSString stringWithFormat:@"[%s] %s [第%d行] %@\n", __TIME__, __FUNCTION__, __LINE__, [NSString stringWithFormat:format, ## __VA_ARGS__]  ]; \
 [[BXGLogMonitor share] addLogInfo:strContent]; \
 } while(0);
//*/
//*
#define RWNetworkLog(format, ...) \
do { \
    NSString *strContent = [NSString stringWithFormat:@"[%s] %s [第%d行] %@\n", __TIME__, __FUNCTION__, __LINE__, [NSString stringWithFormat:format, ## __VA_ARGS__]  ]; \
    [[BXGLogMonitor share] addLogInfo:strContent]; \
} while(0);
//*/
//#else
//#define RWNetworkLog(fmt, ...)
//#endif


#endif /* BXGNetwork_h */
