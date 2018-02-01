//
//  BXGNetworkParser.h
//  Boxuegu
//
//  Created by RenyingWu on 2017/9/4.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BXGMainParserItem.h"

typedef NS_ENUM(NSInteger, BXGNetworkResultStatus) {
    //
    BXGNetworkResultStatusSucceed = 200,
    BXGNetworkResultStatusFailed = 400,
    BXGNetworkResultStatusParserError = 0,
    // error
    BXGNetworkResultStatusServerError = 500,
};

/// 200 成功 400 失败 1001 过期
@interface BXGNetworkParser : NSObject

+ (void)mainNetworkParser:(id)obj andFinished:(void(^)(BXGNetworkResultStatus status, NSString *message, id result))finishedBlock;

@end
