//
//  AppDelegate.m
//  ExampleApp_iOS
//
//  Created by Marcus Westin on 6/13/13.
//  Copyright (c) 2013 WebViewProxy. All rights reserved.
//

#import "AppDelegate.h"
#import "WebViewProxy.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [self _setupProxy];
    [self _createWebView];
    
    return YES;
}

- (void) _createWebView {
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.window.bounds];
    [_window addSubview:webView];
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"WebViewContent" ofType:@"html"];
    NSString* html = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:html baseURL:nil];
}

- (void) _setupProxy {
    [WebViewProxy handleRequestsWithScheme:@"http" handler:^(NSURLRequest *req, WVPResponse *res) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, req);
        [NSURLConnection connectionWithRequest:req delegate:res];
    }];
}

@end
