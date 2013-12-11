//
//  RRNews.m
//  RSSReader
//
//  Created by Alexey on 23.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "RRNews.h"

@interface RRNews ()

@end

@implementation RRNews

- (id)initWithURL:(NSURL *)url nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentURL = [url retain];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _webView.delegate = self;
    [request release];
    request = [[NSURLRequest requestWithURL:currentURL] retain];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [currentURL release];
    [activityView release];
    [logMessage release];
    [request release];
    [super dealloc];
}

#pragma mark - 
#pragma mark UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self addActivityIndicatorView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideActivityIndicatorView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideActivityIndicatorView];
    [self logError:error];
}

#pragma mark -
#pragma mark Actions
- (IBAction)buttonDoneClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Internal
- (void)addActivityIndicatorView {
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView setColor:[UIColor redColor]];
    [activityView startAnimating];
    activityView.center = CGPointMake(160, 240);
    [self.view addSubview:activityView];
}

- (void)hideActivityIndicatorView {
    [activityView stopAnimating];
}

- (void)logError:(NSError *)error {
    [logMessage release];
    logMessage = [[NSString stringWithFormat:@"Web page loading error: %@", error.description] retain];
    NSLog(@"%@", logMessage);
}
@end
