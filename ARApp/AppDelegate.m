//
//  AppDelegate.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 23/09/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "Configuration.h"
#import "DataSource.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Crashlytics/Crashlytics.h>
#import <GAI.h>
#import "Reachability.h"
#import <CRToast/CRToast.h>

@interface AppDelegate ()
@property (nonatomic, strong) UIViewController *startVC;
@property (nonatomic) Reachability *internetReachability;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    //Initialize Crashlytics
#ifndef DEBUG
    [Crashlytics startWithAPIKey:@"7e38bf7551ee7076054f5c1c0bde276e0506a12e"];

    //Initialize Google Analytics
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-57439380-1"];
#endif
    [SVProgressHUD show];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//#warning TODO: REMOVE
//    [defaults removeObjectForKey:kUserLoggedInUserDefaults];
    NSString *userId = [defaults objectForKey:kUserLoggedInUserDefaults];
    if (userId) {
        self.startVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        [[DataSource sharedDataSource] getUserWithIdentifier:userId completion:^(NSDictionary *dict, NSError *error) {
            if (!error) {
                User *user = [[User alloc] initUserWithDictionary:dict];
                self.actualUser = user;
            } else {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                [alert show];
            }
            [SVProgressHUD dismiss];
        }];
    } else {
        self.startVC = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
    self.window.rootViewController = self.startVC;
    
    //Setup visual identity
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    NetworkStatus netStatus = [self.internetReachability currentReachabilityStatus];
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            break;
        }
        case ReachableViaWiFi:
        {
            break;
        }
        case NotReachable:
        {
            NSDictionary *options = @{
                                      kCRToastTextKey : @"No internet connection!",
                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                      kCRToastBackgroundColorKey : [UIColor redColor],
                                      kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                                      kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                                      kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionBottom),
                                      kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                                      };
            [CRToastManager showNotificationWithOptions:options
                                        completionBlock:nil];
            break;
        }
            
    }
}

-(void)setActualUser:(User *)actualUser
{
    if (_actualUser != actualUser) {
        _actualUser = actualUser;
        NSLog(@"Actual user: %@", actualUser.name);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"USER_SET" object:nil];
        [[NSUserDefaults standardUserDefaults] setObject:actualUser.userId forKey:kUserLoggedInUserDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)resetWindowToInitialView
{
    self.actualUser = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LOGOUT" object:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kUserLoggedInUserDefaults];
    [defaults synchronize];
    
    UIViewController *startVC = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    self.window.rootViewController = startVC;
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            break;
        }
        case ReachableViaWiFi:
        {
            break;
        }
        case NotReachable:
        {
            NSDictionary *options = @{
                                      kCRToastTextKey : @"No internet connection!",
                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                      kCRToastBackgroundColorKey : [UIColor redColor],
                                      kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                                      kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                                      kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionBottom),
                                      kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                                      };
            [CRToastManager showNotificationWithOptions:options
                                        completionBlock:nil];
            break;
        }
    }
}

@end
