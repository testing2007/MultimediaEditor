//
//  ViewController.m
//  MultimediaEditor
//
//  Created by apple on 2018/1/26.
//  Copyright © 2018年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "BXGEditMenuView.h"
#import "BXGEditMarklineView.h"

@interface ViewController ()
@property (nonatomic, assign) BOOL bShowEditMenuView;
@property (nonatomic, strong) BXGEditMenuView *editMenuView;

@property (nonatomic, weak) BXGEditMarklineView *marklineView;


@end

@implementation ViewController

#define TEST_CALLBACK(str) NSLog(@"%@", str);

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.contentTxtView installUI];
    
    self.contentTxtView.text = @"App 内购买项目通过访问 App Store 并安全处理来自用户的付款，将商店直接嵌入您的 App。若要使用 App 内购买项目和 Storekit framework（Storekit 框架），您必须拥有最新的 Apple Developer Program License Agreement（《Apple 开发人员许可协议》）和Paid Applications agreement（《付费应用程序协议》）";
    [self.contentTxtView setTextColor:[UIColor blackColor]];
    [self.contentTxtView setEditable:NO];
    [self.contentTxtView setSelectable:YES];

    _editMenuView = [[BXGEditMenuView alloc] initWithContent:@"abc"];
    [self.view addSubview:_editMenuView];
    _editMenuView.hidden = YES;

    [_editMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(_contentTxtView.frame.size.height+_contentTxtView.frame.origin.y+150));
        make.left.equalTo(@10);
        make.right.offset(-10);
        make.height.equalTo(@100);
    }];
}

-(void)didClickCustomMenuAction {
    TEST_CALLBACK(NSStringFromSelector(_cmd))
}

-(void)dismissKeyBoard
{
    [self.contentTxtView resignFirstResponder];
}

- (void)onTapRecognizer:(UIGestureRecognizer*)recognizer {
    NSLog(@"onTapRecognizer");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
//    NSLog(@"selectedRange=[location=%ld, length=%ld]", textView.selectedRange.location, textView.selectedRange.length);
    TEST_CALLBACK(NSStringFromSelector(_cmd))
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    TEST_CALLBACK(NSStringFromSelector(_cmd))
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
 TEST_CALLBACK(NSStringFromSelector(_cmd))
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
 TEST_CALLBACK(NSStringFromSelector(_cmd))
}

- (void)textViewDidEndEditing:(UITextView *)textView {
 TEST_CALLBACK(NSStringFromSelector(_cmd))
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
 TEST_CALLBACK(NSStringFromSelector(_cmd))
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
 TEST_CALLBACK(NSStringFromSelector(_cmd))
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    TEST_CALLBACK(NSStringFromSelector(_cmd))
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    TEST_CALLBACK(NSStringFromSelector(_cmd))
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
  TEST_CALLBACK(NSStringFromSelector(_cmd))
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    TEST_CALLBACK(NSStringFromSelector(_cmd))
    return YES;
}

- (IBAction)showEditMenuView:(id)sender {
    if(_bShowEditMenuView) {
        return ;
    }
    
    _editMenuView.hidden = NO;
    
    _bShowEditMenuView =  YES;
}

- (IBAction)hideEditMenuView:(id)sender {
    if(!_bShowEditMenuView) {
        return ;
    }

    _editMenuView.hidden = YES;
    
    _bShowEditMenuView =  NO;
}

@end
