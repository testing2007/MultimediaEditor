//
//  BXGLogMonitor.m
//  MultimediaEditor
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import "BXGLogMonitor.h"

#pragma mark 只负责调试打印
// LOG
#ifdef DEBUG
#define LOG_ON // Network Log 开关
#else
//#define LOG_ON
#endif

#pragma mark 运行时控制日志是否显示
#define kEnableLog  @"kEnableLog"

@interface BXGLogMonitor()
@property (nonatomic, assign, readwrite) BOOL bEnableLog;
@property (nonatomic, strong) NSMutableArray<NSString*> *arrLog;
@end

@implementation BXGLogMonitor

+(instancetype)share {
    static dispatch_once_t onceToken;
    static BXGLogMonitor *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [BXGLogMonitor new];
        [instance initLogConfig];
    });
    return instance;
}

-(NSMutableArray*)arrLog {
    if(!_arrLog) {
        _arrLog = [NSMutableArray new];
    }
    return _arrLog;
}

-(void)initLogConfig {
    NSNumber *numEnableLog = [[NSUserDefaults standardUserDefaults] objectForKey:kEnableLog];
    _bEnableLog = numEnableLog ? numEnableLog.boolValue : NO;
}

-(void)setEnableLog:(BOOL)enableLog {
    self.bEnableLog = enableLog;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:enableLog] forKey:kEnableLog];
}

-(void)addLogInfo:(NSString*)logInfo {
#ifdef LOG_ON
    printf("%s\n", [logInfo UTF8String]);
#endif
    
    if(!self.bEnableLog) {
        return ;
    }
    
    if(logInfo) {
        [self.arrLog addObject:logInfo];
    }
    if(self.arrLog.count>10) {
        [self.arrLog removeObjectsInRange:NSMakeRange(0, self.arrLog.count/2)];
    }
}

-(NSString*)logInfo {
    NSString *strContent = nil;
    for(NSString *itemLog in self.arrLog){
        if(!strContent) {
            strContent = [NSString new];
        }
        strContent = [strContent stringByAppendingString:itemLog];
    }
    
    return strContent?:@"";
}

@end
