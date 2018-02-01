//
//  BXGEditMenuView.h
//  MultimediaEditor
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXGEditMenuView : UIView
- (instancetype)initWithContent:(NSString*)content;
@property (nonatomic, strong) NSString *content;
@end
