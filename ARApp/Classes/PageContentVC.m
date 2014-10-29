//
//  PageContentVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 10/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "PageContentVC.h"
#import "CaptureVC.h"
#import "RankingVC.h"
#import "UserVC.h"

@interface PageContentVC () <UIPageViewControllerDataSource>
@property (nonatomic, strong) CaptureVC *captureVC;
@property (nonatomic, strong) UserVC *userVC;
@property (nonatomic, strong) RankingVC *rankingVC;

@end

@implementation PageContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create page view controller
    self.dataSource = self;
    
    self.captureVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"CaptureVC"];
    self.userVC = [[UIStoryboard storyboardWithName:@"User" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"UserVC"];
    self.rankingVC = [[UIStoryboard storyboardWithName:@"Ranking" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RankingVC"];
    
    NSArray *viewControllers = @[self.captureVC];
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[CaptureVC class]]) {
        return self.userVC;
    } else if ([viewController isKindOfClass:[RankingVC class]]) {
        return self.captureVC;
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[CaptureVC class]]) {
        return self.rankingVC;
    } else if ([viewController isKindOfClass:[UserVC class]]) {
        return self.captureVC;
    } else {
        return nil;
    }
}



@end
