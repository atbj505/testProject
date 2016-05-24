//
//  TestWebViewController.m
//  testWebView
//
//  Created by Robert on 15/10/26.
//  Copyright © 2015年 NationSky. All rights reserved.
//

#import "TestWebViewController.h"
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"
#import "SDWebImageManager.h"

@interface TestWebViewController () <UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge* bridge;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) NSString *htmlContent;

@property (nonatomic, strong) NSMutableArray *allImagesOfThisArticle;

@end

@implementation TestWebViewController


- (instancetype)initWithType:(TestWebType)type {
    self = [super init];
    if (self) {
        _webType = type;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1231" ofType:@"txt"];
    
    self.htmlContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if (self.webType == TestWebTypeUIWebView) {
        [self addUIWebView];
    }else {
        [self addWKWebView];
    }
}

- (void)addUIWebView {
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    [self editHtml];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"Received message from javascript: %@", data);
        responseCallback(@"Right back atcha");
        [self downloadAllImagesInNative:data];
    }];
    
    
    [_bridge registerHandler:@"imageDidClicked" handler:^(id data, WVJBResponseCallback responseCallback) {
        
//        NSInteger index = [[data objectForKey:@"index"] integerValue];
//        
//        CGFloat originX = [[data objectForKey:@"x"] floatValue];
//        CGFloat originY = [[data objectForKey:@"y"] floatValue];
//        CGFloat width   = [[data objectForKey:@"width"] floatValue];
//        CGFloat height  = [[data objectForKey:@"height"] floatValue];
//        
//        tappedImageView.alpha = 0;
//        tappedImageView.frame = CGRectMake(originX, originY, width, height);
//        tappedImageView.image = _allImagesOfThisArticle[index];//_allImagesOfThisArticle是一个本地数组用来存放所有图片
        
        NSLog(@"OC已经收到JS的imageDidClicked了: %@", data);
        responseCallback(@"OC已经收到JS的imageDidClicked了");
        
        //点击放大图片
//        [self presentPhotosBrowserWithInitialPage:index animatedFromView:tappedImageView];
    }];
    
}

- (void)addWKWebView {
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [webView loadRequest:request];
}

- (void)editHtml {
    NSString *headerPath = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"txt"];
    
    NSString *footerPath = [[NSBundle mainBundle] pathForResource:@"footer" ofType:@"txt"];
    
    NSString *content = [self.htmlContent stringByReplacingOccurrencesOfString:@"src" withString:@"esrc"];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img[^>]+esrc=\")(\\S+)\"" options:0 error:nil];
    NSString *result = [regex stringByReplacingMatchesInString:content options:0 range:NSMakeRange(0, content.length) withTemplate:@"<img esrc=\"$2\" onClick=\"javascript:onImageClick('$2')\""];
    
    result = [NSString stringWithFormat:@"%@%@%@",[NSString stringWithContentsOfFile:headerPath encoding:NSUTF8StringEncoding error:nil], content, [NSString stringWithContentsOfFile:footerPath encoding:NSUTF8StringEncoding error:nil]];
    
    [self.webView loadHTMLString:result baseURL:nil];
}

#pragma mark -- 下载全部图片
-(void)downloadAllImagesInNative:(NSArray *)imageUrls{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //初始化一个置空元素数组
    _allImagesOfThisArticle = [NSMutableArray arrayWithCapacity:imageUrls.count];//本地的一个用于保存所有图片的数组
    for (NSUInteger i = 0; i < imageUrls.count; i++) {
        [_allImagesOfThisArticle addObject:[NSNull null]];
    }
    
    for (NSUInteger i = 0; i < imageUrls.count; i++) {
        NSString *_url = imageUrls[i];
        
        [manager downloadImageWithURL:[NSURL URLWithString:_url] options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if (image) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSString *imgB64 = [UIImageJPEGRepresentation(image, 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    
                    //把图片在磁盘中的地址传回给JS
                    NSString *key = [manager cacheKeyForURL:imageURL];
                    
                    NSString *source = [NSString stringWithFormat:@"data:image/png;base64,%@", imgB64];
                    [_bridge callHandler:@"imagesDownloadComplete" data:@[key,source]];
                    
                });
                
            }
            
        }];
        
    }
    
}
#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"requst:%@",request.URL);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
    NSString *Js = @"document.documentElement.innerHTML";
    self.htmlContent = [webView stringByEvaluatingJavaScriptFromString:Js];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish");
    NSString *Js = @"document.documentElement.innerHTML";
    self.htmlContent = [webView stringByEvaluatingJavaScriptFromString:Js];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"error:%@",error);
}









#pragma mark -
#pragma mark WKWebViewDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"start");
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"commit");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"finish");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"fail");
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    return nil;
}

/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler {
    
}

// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

@end
