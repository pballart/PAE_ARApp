//
//  DataSource.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 17/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "DataSource.h"
#import <Pods/AFNetworking.h>

@interface DataSource ()
@property (nonatomic, strong) AFHTTPRequestOperationManager     *operationManager;
@property (nonatomic, assign) BOOL                              isOnline;
@end

NSString *API_BASE_URL = @"http://147.83.39.196/gloop/Core/";

@implementation DataSource

- (id)init {
    self = [super init];
    if(self) {
        NSURL *url = [NSURL URLWithString:API_BASE_URL];
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        [self.operationManager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        [self.operationManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        __weak DataSource *weakSelf = self;
        _operationManager.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            weakSelf.isOnline = status != AFNetworkReachabilityStatusNotReachable;
        }];
    }
    return self;
}

#pragma mark Public

+ (DataSource *)sharedDataSource {
    static DataSource *__theDataSource = nil;
    if (!__theDataSource) {
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            __theDataSource = [[DataSource alloc] init];
        });
    }
    
    return __theDataSource;
}

//Beers

- (void)getBeerWithIdentifier:(NSString *)identifier
                   completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(identifier!=nil, @"Identifier is nil");
    [keys addObject:@"id"];
    [objects addObject:identifier];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getBirra_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getBeerFromCatchoomWithIdentifier:(NSString *)identifier
                   completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(identifier!=nil, @"Identifier is nil");
    [keys addObject:@"idCatchoom"];
    [objects addObject:identifier];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getBirraCatchoom_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getInfoFromBeer:(NSString *)beerId andUser:(NSString *)userId
             completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(beerId!=nil, @"BeerId is nil");
    NSAssert(userId!=nil, @"UserId is nil");
    
    [keys addObject:@"birra"];
    [objects addObject:beerId];
    [keys addObject:@"user"];
    [objects addObject:userId];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getBirraUser_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getBeersFromUser:(NSString *)userId
              completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(userId!=nil, @"UserId is nil");
    
    [keys addObject:@"user"];
    [objects addObject:userId];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getBirresUser_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getOwnerInfoFromBeer:(NSString *)beerId andLeague:(NSString *)leagueId
                  completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(beerId!=nil, @"BeerId is nil");
    NSAssert(leagueId!=nil, @"LeaguId is nil");
    
    [keys addObject:@"birra"];
    [objects addObject:beerId];
    [keys addObject:@"league"];
    [objects addObject:leagueId];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getOwner_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//Gloop!

- (void)updateBeer:(NSString *)beerId withUser:(NSString *)userId
        completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(beerId!=nil, @"BeerId is nil");
    NSAssert(userId!=nil, @"LeaguId is nil");
    
    [keys addObject:@"birraCatchoom"];
    [objects addObject:beerId];
    [keys addObject:@"user"];
    [objects addObject:userId];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"update_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//Ranking methods

- (void)getRankingTotalWithcompletion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    [keys addObject:@"ranking"];
    [objects addObject:@"total"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getRanking_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getRankingDailyWithcompletion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    [keys addObject:@"ranking"];
    [objects addObject:@"daily"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getRanking_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getRankingWeeklyWithcompletion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    [keys addObject:@"ranking"];
    [objects addObject:@"weekly"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getRanking_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getRankingTopTenUsersWithcompletion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getUsersRanking_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}


//User

- (void)getUserWithIdentifier:(NSString *)identifier
                   completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(identifier!=nil, @"Identifier is nil");
    [keys addObject:@"user"];
    [objects addObject:identifier];
    [keys addObject:@"birres"];
    [objects addObject:@1];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getUser_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getLeagueInfoWithLeagueIdentifier:(NSString *)identifier
                               completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(identifier!=nil, @"Identifier is nil");
    
    [keys addObject:@"league"];
    [objects addObject:identifier];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getLeague_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)getBadgetWithUserIdentifier:(NSString *)identifier
                         completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(identifier!=nil, @"Identifier is nil");
    
    [keys addObject:@"user"];
    [objects addObject:identifier];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"getBadges_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)logInWithEmail:(NSString *)email andPassword:(NSString*)password
            completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(email!=nil, @"Email is nil");
    NSAssert(password!=nil, @"Password is nil");
    
    [keys addObject:@"email"];
    [objects addObject:email];
    [keys addObject:@"password"];
    [objects addObject:password];
    
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"login_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)signInWithEmail:(NSString *)email name:(NSString*)name andPassword:(NSString*)password
            completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"help",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"0",nil];
    
    NSAssert(email!=nil, @"Email is nil");
    NSAssert(password!=nil, @"Password is nil");
    NSAssert(name!=nil, @"Name is nil");
    
    [keys addObject:@"email"];
    [objects addObject:email];
    [keys addObject:@"password"];
    [objects addObject:password];
    [keys addObject:@"user"];
    [objects addObject:name];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"register_1.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        if ([[dict objectForKey:@"error"] isEqual:@0]) {
            block(dict, nil);
        } else {
//            NSInteger num = [[dict objectForKey:@"error"] integerValue];
//            switch (num) {
//                case 1:
//                {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Something went wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    [alert show];
//                }
//                case 2:
//                {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Something went wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    [alert show];
//                }
//                case 3:
//                {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Something went wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    [alert show];
//                }
//                case 4:
//                {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Something went wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    [alert show];
//                }
//                    break;
//                    
//                default:
//                    break;
//            }
            NSError *error = [[NSError alloc] initWithDomain:@"Server error" code:1 userInfo:nil];
            block(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

@end
