//
//  BXGNetworkParser.m
//  Boxuegu
//
//  Created by RenyingWu on 2017/9/4.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "BXGNetworkParser.h"

@implementation BXGNetworkParser

+ (void)mainNetworkParser:(id)obj andFinished:(void(^)(BXGNetworkResultStatus status, NSString *message, id result))finishedBlock; {
    
    if([obj isKindOfClass:NSError.class]) {
        finishedBlock(500,kBXGToastNoNetworkError,nil);
        return;
    }
    
    if(!finishedBlock) {
        return;
    }
    
    if(!obj) {
        
        finishedBlock(0,kBXGToastLodingError,nil);
        return;
    }
    
    BXGMainParserItem *item = [BXGMainParserItem yy_modelWithDictionary:obj];
    if(!item) {
        
        finishedBlock(0,kBXGToastLodingError,nil);
        return;
    }
    
    if (item.success && [item.success boolValue]){
        finishedBlock(BXGNetworkResultStatusSucceed,item.errorMessage,item.resultObject);
    }else {
        finishedBlock(BXGNetworkResultStatusFailed,item.errorMessage,item.resultObject);
    }
}

@end
