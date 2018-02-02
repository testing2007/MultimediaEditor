//
//  BXGLogMonitor.h
//  MultimediaEditor
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BXGLogMonitor : NSObject

+(instancetype)share;

@property (nonatomic, assign, readonly) BOOL bEnableLog;
-(void)setEnableLog:(BOOL)enableLog;

-(void)addLogInfo:(NSString*)logInfo;
-(NSString*)logInfo;

@end
