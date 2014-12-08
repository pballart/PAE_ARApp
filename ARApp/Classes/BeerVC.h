//
//  BeerVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 9/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"

@interface BeerVC : UIViewController
@property (nonatomic, strong) Beer *beer;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic) BOOL hideSplash;
@end
