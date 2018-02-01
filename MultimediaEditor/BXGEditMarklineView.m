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

typedef void (^TapBlockType)(NSInteger nIndex);

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
        [marklineBtn addTarget:self action:@selector(onShowShrinkView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:marklineBtn];
        _tapBlock = tapBlock;
        [marklineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            // make.center.offset(0);
            make.left.right.bottom.top.offset(0);
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
        [marklineBtn setTitle:@"颜色" forState:UIControlStateNormal];
        [marklineBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
        [marklineBtn addTarget:self action:@selector(onShowInflateView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:marklineBtn];
        _tapBlock = tapBlock;
        [marklineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            // make.center.offset(0);
            make.left.right.bottom.top.offset(0);
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
        UIButton *button1=[[UIButton alloc]init];
        button1.tag = 0;
        [button1.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
        [button1 addTarget:self action:@selector(onShowShrinkView:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setTitle:@"红" forState:UIControlStateNormal];
        button1.translatesAutoresizingMaskIntoConstraints=NO;
        [button1 setBackgroundColor:[UIColor redColor]];
        [self addSubview:button1];
        
        UIButton *button2=[[UIButton alloc]init];
        button2.tag = 1;
        [button2.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
        [button2 addTarget:self action:@selector(onShowShrinkView:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitle:@"绿" forState:UIControlStateNormal];
        button2.translatesAutoresizingMaskIntoConstraints=NO;
        [button2 setBackgroundColor:[UIColor greenColor]];
        [self addSubview:button2];
        
        UIButton *button3=[[UIButton alloc]init];
        button3.tag = 2;
        [button3.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
        [button3 setTitle:@"蓝" forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(onShowShrinkView:) forControlEvents:UIControlEventTouchUpInside];
        button3.translatesAutoresizingMaskIntoConstraints=NO;
        [button3 setBackgroundColor:[UIColor blueColor]];
        [self addSubview:button3];
        
        _tapBlock = tapBlock;
        
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.offset(0);
            make.width.equalTo(self.mas_width).dividedBy(3);
        }];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button1.mas_right);
            make.top.bottom.offset(0);
            make.width.equalTo(self.mas_width).dividedBy(3);
        }];
        [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button2.mas_right);
            make.top.bottom.offset(0);
            make.width.equalTo(self.mas_width).dividedBy(3);
        }];
    }
    return self;
}

-(void)onShowShrinkView:(UIButton*)sender {
    if(_tapBlock) {
        NSInteger index = sender.tag;
        _tapBlock(index);
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
    BXGMarklineTextView *textView = [[BXGMarklineTextView alloc] initWithTapBlock:^(NSInteger nIndex) {
        weakSelf.textView.hidden = YES;
        weakSelf.inflateView.hidden = NO;
        weakSelf.shrinkView.hidden = YES;
    }];
    [self addSubview:textView];
    _textView = textView;
    
    BXGMarklineInflateView *inflateView = [[BXGMarklineInflateView alloc] initWithTapBlock:^(NSInteger nIndex) {
        [weakSelf mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@175);
        }];
        
        weakSelf.textView.hidden = YES;
        weakSelf.inflateView.hidden = YES;
        weakSelf.shrinkView.hidden = NO;
    }];
    [self addSubview:inflateView];
    _inflateView = inflateView;
    
    BXGMarklineShrinkView *shrinkView = [[BXGMarklineShrinkView alloc] initWithTapBlock:^(NSInteger nIndex) {
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
