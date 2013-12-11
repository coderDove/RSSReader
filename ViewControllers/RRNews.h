//
//  RRNews.h
//  RSSReader
//
//  Created by Alexey on 23.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRNews : UIViewController <UIWebViewDelegate> {
    UIActivityIndicatorView *activityView;
    NSURL *currentURL;
    NSURLRequest *request;
    NSString *logMessage;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;


- (id)initWithURL:(NSURL*)url nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)buttonDoneClick:(id)sender;

@end
