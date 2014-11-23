//
//  Beer.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 29/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *beerId;
@property (nonatomic, strong) NSString *beerInfo;
@property (nonatomic, strong) NSString *beerImageURL;
@property (nonatomic, strong) NSString *beerBannerURL;
@property (nonatomic, strong) NSString *ownerId;
@property (nonatomic, strong) NSString *beerPoints;
@property (nonatomic, strong) NSString *brandId;
@property (nonatomic, strong) NSString *brandInfo;

-(id)initBeerWithDictionary:(NSDictionary *)dictionary;

@end
