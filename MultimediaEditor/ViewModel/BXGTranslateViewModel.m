//
//  BXGTranslateViewModel.m
//  MultimediaEditor
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import "BXGTranslateViewModel.h"

@implementation BXGTranslateViewModel

- (void)loadRequestTranslateDestLanguageType:(TranslateLanguageType)destLanguageType
                          andTranlateContent:(NSString*)content
                                 andFinished:(void (^)(BOOL bSuccess))finishBlock {
    [[BXGNetworkTool sharedTool] requestTranslateDestLanguageType:destLanguageType andTranlateContent:content andFinished:^(NSInteger status, NSString * _Nullable message, id  _Nullable result) {
        
    }];
}

@end
