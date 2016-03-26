//
//  LVOAuthController.m
//  weibo -OC
//
//  Created by lvdesheng on 16/3/5.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "LVOAuthController.h"
#import "AFNetworking.h"


#import "SVProgressHUD.h"
#import "LVAccountTool.h"



@interface LVOAuthController ()<UIWebViewDelegate>

@end

@implementation LVOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.创建一个webView
    UIWebView *WebView = [[UIWebView alloc]init];
    WebView.frame = self.view.bounds;
    WebView.delegate = self;
    
    [self.view addSubview:WebView];
    
    
    //用webView加载登陆界面
    //https://api.weibo.com/oauth2/authorize
    /**
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1266961611&redirect_uri=http://www.baidu.com"];
    
    NSURLRequest *Request = [NSURLRequest requestWithURL:url];

    [WebView loadRequest:Request];
    
    
    
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"正在加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [SVProgressHUD dismiss];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
        //获取url
    NSString *url = request.URL.absoluteString;
    
    
    //判断是否是回调地址
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.length !=0){//是回调地址
        //截取code=后面的参数值
        NSUInteger fromIndex = range.length + range.location;
        NSString *code = [url substringFromIndex:fromIndex];
        
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];

        return  NO;
    }

    return YES;
    
}

/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    /**
     https://api.weibo.com/oauth2/access_token
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     text/plain
     */
    
    //请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"]     = @"1266961611";
    parameters[@"client_secret"] = @"331390a9396a0cc7f879b5a5a9eb5ded";
    parameters[@"grant_type"]    = @"authorization_code";
    parameters[@"code"]          = code;
    parameters[@"redirect_uri"]  = @"http://www.baidu.com";
    
 
    //发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [SVProgressHUD dismiss];

        
        // 将返回的账号字典数据
        LVAcount *account = [LVAcount accountWithDict:responseObject];
        
        //储存账号信息
        [LVAccountTool saveAccount:account];
        
        //切换window根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LVLog(@"请求失败%@",error);
        [SVProgressHUD dismiss];
    }];
    
    
}


@end
