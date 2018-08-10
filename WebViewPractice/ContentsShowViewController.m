//
//  ContentsShowViewController.m
//  WebViewPractice
//
//  Created by luwentao on 2018/8/10.
//  Copyright © 2018年 cmb. All rights reserved.
//

#import "ContentsShowViewController.h"
#import "WebKit/WebKit.h"
@interface ContentsShowViewController ()<WKNavigationDelegate>
//@property (nonatomic) UIView * contentsContain;
@property (nonatomic) WKWebView * wk;
@end

@implementation ContentsShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat buttonBarWidth = 316;
    
    UIView *contentsContain = [[UIView alloc] initWithFrame:CGRectMake((screen.size.width - buttonBarWidth ) / 2, 20, buttonBarWidth, 30)];
    WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 60, screen.size.width, screen.size.height - 80)];
    self.wk = wkWebView;
    
    UIButton * testLoadHtml = [UIButton buttonWithType:UIButtonTypeSystem];
    [testLoadHtml setTitle:@"loadHtml" forState:UIControlStateNormal];
    testLoadHtml.frame = CGRectMake(0, 0, 177, 30);
    [testLoadHtml addTarget:self action:@selector(testLoadHtml:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * testLoadData = [UIButton buttonWithType:UIButtonTypeSystem];
    [testLoadData setTitle:@"loadData" forState:UIControlStateNormal];
    testLoadData.frame = CGRectMake(137, 0, 67, 30);
    //testLoadData.buttonType = UIButtonTypeSystem;
    [testLoadData addTarget:self action:@selector(testLoadData:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * testLoadRequest = [UIButton buttonWithType:UIButtonTypeSystem ];
    testLoadRequest.frame = CGRectMake(224, 0, 92, 30);
    [testLoadRequest setTitle:@"loadRequest" forState:UIControlStateNormal];
    [testLoadRequest addTarget:self action:@selector(testLoadRequest:) forControlEvents:UIControlEventTouchUpInside];
    
    [contentsContain addSubview:testLoadHtml];
    [contentsContain addSubview:testLoadData];
    [contentsContain addSubview:testLoadRequest];
    
    [self.view addSubview:contentsContain];
    [self.view addSubview:wkWebView];
    //self.wk.backgroundColor = [UIColor blueColor];
    
}
- (void) testLoadHtml:(UIButton *) sender{
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"baidu" ofType:@"html"];
    NSURL * baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSError *error = nil;
    NSString * html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error ];
    if(error == nil){
        //NSLog(@"出错");
        [self.wk loadHTMLString:html baseURL:baseUrl];
    }
}

- (void) testLoadData:(UIButton *) sender{
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"baidu" ofType:@"html"];
    NSURL * baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSData * htmlData = [[NSData alloc] initWithContentsOfFile:htmlPath ];
    [self.wk loadData:htmlData MIMEType:@"text/html" characterEncodingName:@"UTF-8" baseURL:baseUrl];
}


- (void) testLoadRequest:(UIButton*)sender{
    NSLog(@"en ...");
    NSURL * url = [NSURL URLWithString:@"http://www.51work.com"];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [self.wk loadRequest:urlRequest];
    self.wk.navigationDelegate = self;
    NSLog(@"finish ...");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- 加载前
- (void) webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载");
}
#pragma  mark -- 数据已经返回
- (void) webView:(WKWebView*)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"数据返回");
}
#pragma mark -- 数据加载完毕
- (void) webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@"加载完成了");
}
#pragma mark -- 数据加载出错
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"数据加载出错，%@" , error.description);
}
@end
