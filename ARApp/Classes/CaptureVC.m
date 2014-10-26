//
//  CaptureVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 10/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "CaptureVC.h"
#import <CatchoomSDK/CatchoomSDK.h>
#import <CatchoomSDK/CatchoomCloudRecognitionItem.h>
#import <pop/POP.h>
#import "DataSource.h"

@interface CaptureVC () <CatchoomCloudRecognitionProtocol, CatchoomSDKProtocol, UIAlertViewDelegate, POPAnimationDelegate> {
    // Catchoom SDK reference
    CatchoomSDK *_sdk;
    CatchoomCloudRecognition *_cloudRecognition;
}


@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (nonatomic, strong) DataSource *dataSource;

@end

@implementation CaptureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the data source
    self.dataSource = [DataSource sharedDataSource];

    // Setup the Catchoom SDK
    _sdk = [CatchoomSDK sharedCatchoomSDK];
    [_sdk setDelegate:self];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    
    // Start Video Preview for search and tracking
    [_sdk startCaptureWithView: self.cameraView];
}


- (IBAction)scanButtonPressed:(UIButton *)sender {
    [_sdk takeSnapshot];
    [SVProgressHUD show];
    
    //animate button
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.delegate = self;
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGSize:CGSizeMake(1.5, 1.5)];
    anim.springSpeed = 20;
    anim.springBounciness = 20;
    [sender pop_addAnimation:anim forKey:@"scanButton"];
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidReachToValue:(POPAnimation *)anim {
    //Turn button to original size
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    animation.springSpeed = 20;
    animation.springBounciness = 20;
    [self.scanButton pop_addAnimation:animation forKey:@"scanButtonBack"];
}

#pragma mark - CatchoomSDK Delegate

- (void) didStartCapture {
    // Get the CloudRecognition and set self as delegate to receive search responses
    _cloudRecognition = [_sdk getCloudRecognitionInterface];
    [_cloudRecognition setDelegate:self];
    [_cloudRecognition setToken:@"cbaf95971df4436c"];
}

-(void)didGetSnapshot:(UIImage *)snapshot
{
    [_cloudRecognition searchWithUIImage:snapshot];
    
}

#pragma mark - CatchoomCloudRecognition Delegate

- (void) didGetSearchResults:(NSArray *)resultItems {
    if ([resultItems count] >= 1) {
        // Found one item !!!
        NSLog(@"Trobat!");
        CatchoomCloudRecognitionItem *item = [resultItems objectAtIndex:0];
        [self.dataSource getBeerWithIdentifier:item.itemId completion:^(NSDictionary *dict, NSError *error) {
            NSLog(@"Received response: %@", dict);
            [SVProgressHUD dismiss];
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Nothing found"];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
    }
}

-(void)didFailWithError:(CatchoomSDKError *)error {
    NSLog(@"Error: %@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No trobat..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [SVProgressHUD dismiss];
}

-(void)didValidateToken
{
    NSLog(@"Token validated");
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [_sdk unfreezeCapture];
}



@end
