//
//  ViewController.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 23/09/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "ViewController.h"
#import "PageContentVC.h"
#import "CaptureVC.h"
#import "UserVC.h"
#import "RankingVC.h"
#import "WelcomeVC.h"


@interface ViewController () <UIPageViewControllerDataSource> 

@property (strong, nonatomic) PageContentVC *pageViewController;
@property (nonatomic) NSUInteger pageIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentVC"];
    self.pageViewController.dataSource = self;
    
    PageContentVC *captureVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CaptureVC"];
    NSArray *viewControllers = @[captureVC];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    //Set the index
    self.pageIndex = 1;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[CaptureVC class]]) {
        return [[UIStoryboard storyboardWithName:@"User" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"UserVC"];
    } else if ([viewController isKindOfClass:[RankingVC class]]) {
        return [[UIStoryboard storyboardWithName:@"Ranking" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"CaptureVC"];
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[CaptureVC class]]) {
        return [[UIStoryboard storyboardWithName:@"Ranking" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RankingVC"];
    } else if ([viewController isKindOfClass:[UserVC class]]) {
        return [self.storyboard instantiateViewControllerWithIdentifier:@"CaptureVC"];
    } else {
        return nil;
    }
}


@end
