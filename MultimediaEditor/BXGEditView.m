//
//  BXGEditView.m
//  MultimediaEditor
//
//  Created by apple on 2018/1/27.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import "BXGEditView.h"
#import <stdlib.h>

@interface BXGEditView()

@property (nonatomic, assign) CGPoint ptBegin;
@property (nonatomic, assign) CGPoint ptEnd;
@end

@implementation BXGEditView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        [self installUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self installUI];
    return self;
}

- (instancetype)init {
    self = [super init];
    [self installUI];
    return self;
}

- (void)selText {
    int startLocation = 0;
    int endLocation = 0;
    if(_ptEnd.x>=_ptBegin.x && _ptEnd.y>=_ptBegin.y) {
        //右下
        startLocation = [self location:_ptBegin];
        endLocation = [self location:_ptEnd];
        self.selectedRange = NSMakeRange(startLocation, endLocation-startLocation);
    } else if(_ptEnd.x>=_ptBegin.x && _ptEnd.y<=_ptBegin.y) {
        //右上
        NSLog(@"右上");
        startLocation = [self location:_ptEnd];
        endLocation = [self location:_ptBegin];
        self.selectedRange = NSMakeRange(startLocation, endLocation-startLocation);
        //        startRange = (_ptBegin.y/nEachRowLen)*nEachRowLen + _ptBegin.x/10;
    } else if(_ptEnd.x<=_ptBegin.x && _ptEnd.y<=_ptBegin.y) {
        //左上
        NSLog(@"左上");
        startLocation = [self location:_ptEnd];
        endLocation = [self location:_ptBegin];
        self.selectedRange = NSMakeRange(startLocation, endLocation-startLocation);
    } else if(_ptEnd.x<=_ptBegin.x && _ptEnd.y>=_ptBegin.y) {
        //左下
        NSLog(@"左下");
        startLocation = [self location:_ptBegin];
        endLocation = [self location:_ptEnd];
        self.selectedRange = NSMakeRange(startLocation, endLocation-startLocation);
    }
//     self.selectedRange = NSMakeRange(1, 100);
}

-(int)location:(CGPoint)pt {
    int location = 0;
    
    UIEdgeInsets margin = UIEdgeInsetsMake(10, 5, 10, 5);
    int nEachColWidth = 11;
    int nEachRowHeight = 10+5;
    int nEachRowLen = (self.bounds.size.width-(margin.left+margin.right)) / nEachColWidth;

    int nBeginRow = pt.y/nEachRowHeight;
    int nRowCount = nBeginRow>1?((nBeginRow-1)*nEachRowLen):0;
    int nStartRowCount = nBeginRow>=1?pt.x/nEachColWidth:0;
    location =  nRowCount + nStartRowCount;

    return location;
}

-(void)longPressTxt:(UILongPressGestureRecognizer*)longPressRecognizer {
    switch(longPressRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint ptBegin = [longPressRecognizer locationInView:self];
            NSLog(@"the state begin, pt={x=%f, y=%f}", ptBegin.x, ptBegin.y);
            _ptBegin = ptBegin;
        } break;
        case UIGestureRecognizerStateEnded: {
            CGPoint ptEnd = [longPressRecognizer locationInView:self];
            NSLog(@"the state end, pt={x=%f, y=%f}", ptEnd.x, ptEnd.y);
            _ptEnd = ptEnd;
            [self selText];
        } break;
        default: {
            CGPoint pt = [longPressRecognizer locationInView:self];
            NSLog(@"the state=%ld, pt={x=%f, y=%f}", longPressRecognizer.state, pt.x, pt.y);
        } break;
    }
}

-(void)installUI {
    UILongPressGestureRecognizer *recognizer = [UILongPressGestureRecognizer new];
    [recognizer addTarget:self action:@selector(longPressTxt:)];
    [self addGestureRecognizer:recognizer];
}

//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(onClickMarkline:)) {
//        return YES;
//    }
//    return NO;
//}
//
//- (void)onClickMarkline:(id)sender {
//    NSLog(@"onClickMarkline");
//}



@end
