//
//  AppDelegate.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 23/09/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User *actualUser;

- (void)resetWindowToInitialView;

@end

