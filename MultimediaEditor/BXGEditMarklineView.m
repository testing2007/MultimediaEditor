//
//  BXGEditMarklineView.m
//  MultimediaEditor
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 itheima. All rights reserved.
//
#import "BXGEditMarklineView.h"

typedef enum {
    MarklineTypeText=0,
    MarklineTypeShrink,  //收缩
    MarklineTypeInflate, //展开
}MarklineType;

typedef void (^TapBlockType)(int nIndex);

@interface BXGMarklineTextView : UIView
@property (nonatomic, assign) MarklineType marklineType;
@property (nonatomic, copy) TapBlockType tapBlock;
@end
@implementation BXGMarklineTextView
- (instancetype)initWithTapBlock:(TapBlockType)tapBlock {
    self = [super init];
    if(self) {
        UIButton *marklineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [marklineBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
        [marklineBtn setTitle:@"划线" forState:UIControlStateNormal];
        [marklineBtn setTitleColor:[UIColor colorWithHex:0xDD0000] forState:UIControlStateNormal];
        [marklineBtn addTarget:self action:@selector(onShowShrinkView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:marklineBtn];
        _tapBlock = tapBlock;
        [marklineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
    }
    return self;
}

-(void)onShowShrinkView:(UIButton*)sender {
    if(_tapBlock) {
        _tapBlock(0);
    }
}
@end

@interface BXGMarklineShrinkView : UIView
@property (nonatomic, assign) MarklineType marklineType;
@property (nonatomic, copy) TapBlockType tapBlock;
@end
@implementation BXGMarklineShrinkView
- (instancetype)initWithTapBlock:(TapBlockType)tapBlock {
    self = [super init];
    if(self) {
        UIButton *marklineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [marklineBtn setImage:[UIImage imageNamed:@"shrink"] forState:UIControlStateNormal];
        [marklineBtn addTarget:self action:@selector(onShowInflateView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:marklineBtn];
        _tapBlock = tapBlock;
        [marklineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
    }
    return self;
}

-(void)onShowInflateView:(UIButton*)sender {
    if(_tapBlock) {
        _tapBlock(0);
    }
}
@end

@interface BXGMarklineInflateView : UIView
@property (nonatomic, assign) MarklineType marklineType;
@property (nonatomic, copy) TapBlockType tapBlock;
@end
@implementation BXGMarklineInflateView
- (instancetype)initWithTapBlock:(TapBlockType)tapBlock {
    self = [super init];
    if(self) {
        UIButton *marklineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [marklineBtn setTitle:@"颜色" forState:UIControlStateNormal];
        [marklineBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
        [marklineBtn addTarget:self action:@selector(onShowShrinkView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:marklineBtn];
        _tapBlock = tapBlock;
        [marklineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
    }
    return self;
}

-(void)onShowShrinkView:(UIButton*)sender {
    if(_tapBlock) {
        _tapBlock(0);
    }
}
@end



#pragma mark BXGEditMarklineView implementation

@interface BXGEditMarklineView()
@property (nonatomic, weak) BXGMarklineTextView *textView;
@property (nonatomic, weak) BXGMarklineInflateView *inflateView;
@property (nonatomic, weak) BXGMarklineShrinkView *shrinkView;
@end

@implementation BXGEditMarklineView

-(instancetype)init {
    self = [super init];
    if(self) {
        [self installUI];
    }
    return self;
}

-(void)installUI {
    __weak typeof(self) weakSelf = self;
    BXGMarklineTextView *textView = [[BXGMarklineTextView alloc] initWithTapBlock:^(int nIndex) {
        weakSelf.textView.hidden = YES;
        weakSelf.inflateView.hidden = NO;
        weakSelf.shrinkView.hidden = YES;
    }];
    [self addSubview:textView];
    _textView = textView;
    
    BXGMarklineInflateView *inflateView = [[BXGMarklineInflateView alloc] initWithTapBlock:^(int nIndex) {
        [weakSelf mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@175);
        }];
        
        weakSelf.textView.hidden = YES;
        weakSelf.inflateView.hidden = YES;
        weakSelf.shrinkView.hidden = NO;
    }];
    [self addSubview:inflateView];
    _inflateView = inflateView;
    
    BXGMarklineShrinkView *shrinkView = [[BXGMarklineShrinkView alloc] initWithTapBlock:^(int nIndex) {
        [weakSelf mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@75);
        }];
        
        weakSelf.textView.hidden = YES;
        weakSelf.inflateView.hidden = NO;
        weakSelf.shrinkView.hidden = YES;
    }];
    [self addSubview:shrinkView];
    _shrinkView = shrinkView;
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.offset(0);
    }];
    [inflateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.offset(0);
    }];
    [shrinkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.offset(0);
    }];
    
    _textView.hidden = NO;
    _inflateView.hidden = YES;
    _shrinkView.hidden = YES;
}

@end
