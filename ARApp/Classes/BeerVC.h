//
//  BeerVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 9/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"

extern const struct BeerParameters {
    __unsafe_unretained NSString *ownerName;
    __unsafe_unretained NSString *becomeOwner;
    __unsafe_unretained NSString *pointsMade;
    __unsafe_unretained NSString *lastCheck;
    __unsafe_unretained NSString *beerInfo;
    __unsafe_unretained NSString *changeLeague;
    __unsafe_unretained NSString *weekDay;
    __unsafe_unretained NSString *dayChecks;
} BeerParameters;

@interface BeerVC : UIViewController
@property (nonatomic, strong) Beer *beer;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic) BOOL hideSplash;
@end
