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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//#warning TODO: REMOVE
//    [defaults removeObjectForKey:kUserLoggedInUserDefaults];
    UIViewController *startVC;
    NSString *userId = [defaults objectForKey:kUserLoggedInUserDefaults];
    if (userId) {
        startVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        [[DataSource sharedDataSource] getUserWithIdentifier:userId completion:^(NSDictionary *dict, NSError *error) {
            if (!error) {
                User *user = [[User alloc] initUserWithDictionary:dict];
                self.actualUser = user;
            } else {
                NSLog(@"Error logging in: %@", error);
            }
        }];
    } else {
        startVC = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
    self.window.rootViewController = startVC;
    
    //Setup visual identity
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    return YES;
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

@end
