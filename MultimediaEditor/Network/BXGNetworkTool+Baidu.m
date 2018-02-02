//
//  BXGNetworkTool+Baidu.m
//  MultimediaEditor
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 itheima. All rights reserved.
//
#define kBaiduAppId @"20180201000120326"
#define kBaiduKey @"2L4BXD5StxHLZuPjtzmm"

#import "BXGNetworkTool+Baidu.h"

@implementation BXGNetworkTool (Baidu)

//字段名    类型    必填参数    描述    备注
//q    TEXT    Y    请求翻译query    UTF-8编码
//from    TEXT    Y    翻译源语言    语言列表(可设置为auto)
//to    TEXT    Y    译文语言    语言列表(不可设置为auto)
//appid    INT    Y    APP ID    可在管理控制台查看
//salt    INT    Y    随机数
//sign    TEXT    Y    签名    appid+q+salt+密钥 的MD5值

//签名生成方法如下：
//1、将请求参数中的 APPID(appid), 翻译query(q, 注意为UTF-8编码), 随机数(salt), 以及平台分配的密钥(可在管理控制台查看)
//按照 appid+q+salt+密钥 的顺序拼接得到字符串1。
//2、对字符串1做md5，得到32位小写的sign。

//例：将apple从英文翻译成中文：
//请求参数：
//q=apple
//from=en
//to=zh
//appid=2015063000000001
//salt=1435660288
//平台分配的密钥: 12345678
//生成sign：
//>拼接字符串1
//拼接appid=2015063000000001+q=apple+salt=1435660288+密钥=12345678
//得到字符串1 =2015063000000001apple143566028812345678
//>计算签名sign（对字符串1做md5加密，注意计算md5之前，串1必须为UTF-8编码）
//sign=md5(2015063000000001apple143566028812345678)
//sign=f89f9594663708c1605f3d736d01d2d4
//完整请求为：
//http://api.fanyi.baidu.com/api/trans/vip/translate?q=apple&from=en&to=zh&appid=2015063000000001&salt=1435660288&sign=f89f9594663708c1605f3d736d01d2d4
//也可以使用POST方法传送需要的参数。

//什么是URL encode？
//网络标准RFC 1738规定了URL中只能使用英文字母、阿拉伯数字和某些标点符号，不能使用其他文字和符号。如果您需要翻译的文本里面出现了不在该规定范围内的字符（比如中文），需要通过URL encode将需要翻译的文本做URL编码才能发送HTTP请求。大部分编程语言都有现成的URL encode函数，具体使用方法可以针对您使用的编程语言自行搜索。
//
//3. 为什么我的请求总是返回错误码54001？
//54001表示签名错误，请检查您的签名生成方法是否正确。
//应该对 appid+q+salt+密钥 拼接成的字符串做MD5得到32位小写的sign。确保要翻译的文本q为UTF-8编码。
//注意在生成签名拼接 appid+q+salt+密钥 字符串时，q不需要做URL encode，在生成签名之后，发送HTTP请求之前才需要对要发送的待翻译文本字段q做URL encode。
//如果您无法确认自己生成签名的结果是否正确，可以将您生成的签名结果和在https://md5jiami.51240.com/中生成的常规md5加密-32位小写签名结果对比。

- (void)baseRequestType:(RequestType)type
           andUrlString:(NSString * _Nullable) urlString
           andParameter:(id _Nullable)para
            andFinished:(BXGNetworkCallbackBlockType _Nullable) finished {
    [self requestType:type andBaseURLString:kBaiduBaseURL andUrlString:urlString andParameter:para andFinished:^(id  _Nullable responseObject) {
        [BXGNetworkParser mainNetworkParser:responseObject andFinished:finished];
    } andFailed:^(NSError * _Nonnull error) {
        [BXGNetworkParser mainNetworkParser:error andFinished:finished];
    }];
}

- (void)requestTranslateDestLanguageType:(TranslateLanguageType)destLanguageType
                      andTranlateContent:(NSString*)content
                             andFinished:(BXGNetworkCallbackBlockType _Nullable) finished {
    //q    TEXT    Y    请求翻译query    UTF-8编码
    //from    TEXT    Y    翻译源语言    语言列表(可设置为auto)
    //to    TEXT    Y    译文语言    语言列表(不可设置为auto)
    //appid    INT    Y    APP ID    可在管理控制台查看
    //salt    INT    Y    随机数
    //sign    TEXT    Y    签名    appid+q+salt+密钥 的MD5值
    // para
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"q"] = content;
    para[@"from"] = @"auto";
    NSAssert(destLanguageType!=TRANSLATE_LANGUAGE_AUTO, @"dest language shouldn't be auto");
    para[@"to"] = destLanguageType==TRANSLATE_LANGUAGE_ZH?@"zh":@"en";

    //...
    
    // url
    NSString *url = @"api/trans/vip/translate";
    
    // request
    [self baseRequestType:POST andUrlString:url andParameter:para andFinished:finished];
}

@end
