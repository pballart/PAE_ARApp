//
//  WebVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 28/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
