//
//  BXGNetwork.h
//  Boxuegu
//
//  Created by RenyingWu on 2017/12/5.
//  Copyright © 2017年 itcast. All rights reserved.
//

#ifndef BXGNetwork_h
#define BXGNetwork_h
#import "BXGNetworkParser.h"

#define kBaiduParseURL http://api.fanyi.baidu.com/api/trans/vip/translate
#define MainBaseUrlString @""

// LOG
#ifdef DEBUG
#define NETWORK_LOG_ON // Network Log 开关
#else
//#define NETWORK_LOG_ON
#endif

#ifdef NETWORK_LOG_ON
#define RWNetworkLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define RWNetworkLog(fmt, ...)
#endif

#endif /* BXGNetwork_h */
