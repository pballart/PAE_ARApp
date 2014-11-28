//
//  WebVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 28/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "WebVC.h"

@implementation WebVC

-(void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
