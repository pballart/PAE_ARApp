//
//  DataSource.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 17/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

+ (DataSource *)sharedDataSource;

- (void)getBeerWithIdentifier:(NSString *)identifier
                completion:(void(^)(NSDictionary *dict, NSError *error))block;

@end
