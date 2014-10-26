//
//  DataSource.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 17/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "DataSource.h"
#import <AFNetworking/AFNetworking.h>

#define API_BASE_URL @"http://147.83.39.196/gloop/"

@interface DataSource ()
@property (nonatomic, strong) AFHTTPRequestOperationManager     *operationManager;
@property (nonatomic, assign) BOOL                              isOnline;
@end

@implementation DataSource

- (id)init {
    self = [super init];
    if(self) {
        NSURL *url = [NSURL URLWithString:API_BASE_URL];
        self.operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        //[self.operationManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
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

- (void)getBeerWithIdentifier:(NSString *)identifier
                   completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"action",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"get_beer",nil];
    
    if (identifier) {
        [keys addObject:@"id"];
        [objects addObject:identifier];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"beers.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        block(dict, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)logInWithEmail:(NSString *)email andPassword:(NSString*)password
            completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"action",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"login",nil];
    
    if (email && password) {
        [keys addObject:@"email"];
        [objects addObject:email];
        [keys addObject:@"password"];
        [objects addObject:password];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"users.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        block(dict, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)signInWithEmail:(NSString *)email name:(NSString*)name andPassword:(NSString*)password
            completion:(void(^)(NSDictionary *dict, NSError *error))block {
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"action",nil];
    NSMutableArray *objects = [[NSMutableArray alloc] initWithObjects:@"register",nil];
    
    if (email && name && password) {
        [keys addObject:@"email"];
        [objects addObject:email];
        [keys addObject:@"password"];
        [objects addObject:password];
        [keys addObject:@"name"];
        [objects addObject:name];
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [self.operationManager POST:@"users.php" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        block(dict, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

#pragma mark - Private methods

- (NSError *)errorWithResult:(NSDictionary *)result inOperation:(AFHTTPRequestOperation *)operation
{
    if ([result objectForKey:@"responseCode"] && ![[result objectForKey:@"responseCode"] isEqualToString:@"200"]) {
        return [NSError errorWithDomain:@"AppDomain" code:[[result objectForKey:@"responseCode"] integerValue] userInfo:nil];
    }
    return nil;
}

@end
