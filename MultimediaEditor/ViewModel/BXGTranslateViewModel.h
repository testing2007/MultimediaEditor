//
//  BXGTranslateViewModel.h
//  MultimediaEditor
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import "BXGBaseViewModel.h"

@interface BXGTranslateViewModel : BXGBaseViewModel

- (void)loadRequestTranslateDestLanguageType:(TranslateLanguageType)destLanguageType
                          andTranlateContent:(NSString*)content
                                 andFinished:(void (^)(BOOL bSuccess))finishBlock;

@end
