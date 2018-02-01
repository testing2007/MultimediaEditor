//
//  BXGEditMenuView.m
//  MultimediaEditor
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import "BXGEditMenuView.h"
#import "BXGEditMarklineView.h"

@interface BXGEditMenuView()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) UIButton *rightBtn;

@property (nonatomic, weak) UITextView *contentView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, weak) BXGEditMarklineView *marklineView;
@end

@implementation BXGEditMenuView

- (instancetype)initWithContent:(NSString *)content {
    self = [super init];
    if(self) {
        self.content = content;
        [self installUI];
    }
    return self;
}

- (void)installUI {
    //*
    self.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.8];

    UIScrollView* scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView flashScrollIndicators];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor colorWithHex:0xFF0000 alpha:1];
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    
    BXGEditMarklineView *marklineView = [[BXGEditMarklineView alloc] init];
    [scrollView addSubview:marklineView];
    _marklineView = marklineView;
    
    UIButton *noteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noteBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
    [noteBtn setTitle:@"笔记" forState:UIControlStateNormal];
    [noteBtn addTarget:self action:@selector(onNote:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:noteBtn];
    
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [copyBtn addTarget:self action:@selector(onCopy:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:copyBtn];
    
    UIButton *dictBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dictBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
    [dictBtn setTitle:@"字典" forState:UIControlStateNormal];
    [dictBtn addTarget:self action:@selector(onDict:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:dictBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(onShare:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:shareBtn];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, 0, 0);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(inset.left));
        make.right.equalTo(@(-inset.right));
        make.top.offset(0);
        make.height.equalTo(@60);
    }];
    
    [marklineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
//        make.width.mas_equalTo(scrollView.mas_width).dividedBy(4.0);
        make.width.mas_equalTo(@75);
        make.height.equalTo(super.mas_height);
    }];
    [noteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(marklineView.mas_right);
        make.top.offset(0);
//        make.width.mas_equalTo(@75);
        make.width.mas_equalTo(scrollView.mas_width).dividedBy(4.0);
        make.height.equalTo(super.mas_height);
    }];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noteBtn.mas_right);
        make.top.offset(0);
        make.width.mas_equalTo(noteBtn.mas_width);
        make.height.equalTo(super.mas_height);
    }];
    [dictBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(copyBtn.mas_right);
        make.top.offset(0);
        make.width.mas_equalTo(copyBtn.mas_width);
        make.height.equalTo(super.mas_height);
    }];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dictBtn.mas_right);
        make.top.offset(0);
        make.width.mas_equalTo(dictBtn.mas_width);
        make.height.equalTo(super.mas_height);
    }];
    
    [scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(shareBtn.mas_right);
    }];
    
    //添加左右两边按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
    [leftBtn setTitle:@"左" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(onLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    _leftBtn = leftBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn.titleLabel setFont:[UIFont bxg_fontRegularWithSize:15]];
    [rightBtn setTitle:@"右" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(onRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    _rightBtn = rightBtn;
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.equalTo(@20);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.width.equalTo(@20);
    }];
}

- (void)onLeftBtn:(UIButton*)sender {
    if(self.scrollView.contentOffset.x > 0) {
        CGFloat offsetX = self.scrollView.contentOffset.x;
        offsetX =  offsetX-5<0 ? offsetX-5 : 0;
        [self.scrollView setContentOffset:CGPointMake(offsetX, self.scrollView.contentOffset.y)];
        [self controlScrollViewIndicate];
    }
}

- (void)onRightBtn:(UIButton*)sender {
    if(self.scrollView.contentSize.width-self.scrollView.contentOffset.x > self.bounds.size.width) {
        CGFloat maxContentOffsetX = self.scrollView.contentSize.width-self.bounds.size.width;
        CGFloat offsetX = self.scrollView.contentOffset.x;
        offsetX =  offsetX+5>maxContentOffsetX ? maxContentOffsetX : offsetX+5;
        [self.scrollView setContentOffset:CGPointMake(offsetX, self.scrollView.contentOffset.y)];
        [self controlScrollViewIndicate];
    }
}

- (void)onMarkline:(UIButton*)sender {
    
}

- (void)onNote:(UIButton*)sender {
    
}

- (void)onCopy:(UIButton*)sender {
    
}

- (void)onDict:(UIButton*)sender {
    
}

- (void)onShare:(UIButton*)sender {
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%@, the contentOffset w=%f, contentSize w=%f",  NSStringFromSelector(_cmd), scrollView.contentOffset.x, scrollView.contentSize.width);
    [self controlScrollViewIndicate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%@, the contentOffset w=%f, contentSize w=%f",  NSStringFromSelector(_cmd), scrollView.contentOffset.x, scrollView.contentSize.width);
    [self controlScrollViewIndicate];
}

- (void)controlScrollViewIndicate {
    if(_scrollView.contentOffset.x==0) {
        _leftBtn.hidden = YES;
        if(_scrollView.contentSize.width>self.bounds.size.width) {
            _rightBtn.hidden = NO;
        } else {
            _rightBtn.hidden = YES;
        }
    } else {
        _leftBtn.hidden = NO;
        if(_scrollView.contentSize.width-_scrollView.contentOffset.x>self.bounds.size.width) {
            _rightBtn.hidden = NO;
        } else {
            _rightBtn.hidden = YES;
        }
    }
}

@end
