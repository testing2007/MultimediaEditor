//
//  BXGNetworkTool+Baidu.h
//  MultimediaEditor
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import "BXGNetworkTool.h"

typedef enum {
    TRANSLATE_LANGUAGE_AUTO,
    TRANSLATE_LANGUAGE_ZH,
    TRANSLATE_LANGUAGE_EN
}TranslateLanguageType;

@interface BXGNetworkTool (Baidu)

- (void)requestTranslateDestLanguageType:(TranslateLanguageType)destLanguageType
                      andTranlateContent:(NSString*)content
                             andFinished:(BXGNetworkCallbackBlockType _Nullable) finished;

@end
