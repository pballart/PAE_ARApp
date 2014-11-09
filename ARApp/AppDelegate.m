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
            if (dict && !error) {
                User *user = [[User alloc] initUserWithDictionary:dict];
                self.actualUser = user;
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
        [[NSUserDefaults standardUserDefaults] setObject:actualUser.userId forKey:kUserLoggedInUserDefaults];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
