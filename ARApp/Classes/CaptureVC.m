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
#import <SVProgressHUD/SVProgressHUD.h>


@interface CaptureVC () <CatchoomCloudRecognitionProtocol, CatchoomSDKProtocol, POPAnimationDelegate> {
    // Catchoom SDK reference
    CatchoomSDK *_sdk;
    CatchoomCloudRecognition *_cloudRecognition;
}


@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (nonatomic, strong) DataSource *dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *helpImageView;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissHelpButton;
@property (weak, nonatomic) IBOutlet UIImageView *captureGuideImageView;

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
    [self.view setNeedsLayout];
    
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

#pragma mark - Help Methods

- (IBAction)showHelp:(UIButton *)sender {
    [self.helpImageView setHidden:NO];
    [self.dismissHelpButton setHidden:NO];
    [self.helpButton setHidden:YES];
    [self.captureGuideImageView setImage:[UIImage imageNamed:@"capture_guide_shadow"]];
}

- (IBAction)hideHelp:(UIButton *)sender {
    [self.helpImageView setHidden:YES];
    [self.dismissHelpButton setHidden:YES];
    [self.helpButton setHidden:NO];
    [self.captureGuideImageView setImage:[UIImage imageNamed:@"capture_guide"]];
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
        if (item.itemName) {
            [self showBeerFoundAlertWithName:item.itemName];
        }
    } else {
        [SVProgressHUD dismiss];
        [self showNothingFoundAlert];
    }
}

-(void)didFailWithError:(CatchoomSDKError *)error {
    NSLog(@"Error: %@", error);
    [SVProgressHUD dismiss];
    [self showNothingFoundAlert];
    
}

-(void)showBeerFoundAlertWithName:(NSString *)name {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:name];
    [alert addButtonWithTitle:@"Ok"];
    [alert show];
}

-(void)showNothingFoundAlert {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Nothing found"];
    [alert addButtonWithTitle:@"Ok"];
    [alert show];
}

-(void)didValidateToken
{
    NSLog(@"Token validated");
}



@end
