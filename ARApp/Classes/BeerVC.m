//
//  BeerVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 9/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "BeerVC.h"
#import "AppDelegate.h"
#import <Pods/UIImageView+AFNetworking.h>
#import "User.h"

#define BASE_URL @"http://147.83.39.196"

@interface BeerVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *splashView;
@property (weak, nonatomic) IBOutlet UILabel *earnedPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *becomesOwnerLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *leagueLabel;
@property (weak, nonatomic) IBOutlet UILabel *numGloopsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *gloopsDoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel2;
@property (weak, nonatomic) IBOutlet UIView *descriptionView;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *featuresViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *featuresView;


@end

@implementation BeerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.hideSplash) {
        [self.splashView setHidden:YES];
    } else {
        //Fullfill splash info
        if ([[self.params objectForKey:@"becomeOwner"] integerValue] == 3) {
            //Becomes new propietari
            //Show label
            [self.becomesOwnerLabel setHidden:NO];
            //Play sound
            
        }
        //Change league
//        if ([[self.params objectForKey:BeerParameters.changeLeague] integerValue] == 3) {
//            //Becomes new propietari
//            //Show label
//            [self.becomesOwnerLabel setHidden:NO];
//            //Play sound
//            
//        }
    }
    self.featuresViewHeightConstraint.constant = 66;
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.scrollView.contentSize.height)];
    User *actualUser = ((AppDelegate *)[UIApplication sharedApplication].delegate).actualUser;
    
    //Process the info from dictionary
    self.beer = [[Beer alloc] initBeerWithDictionary:[self.params objectForKey:@"birra"]];
    
    //Set the labels text
    self.earnedPointsLabel.text = [[self.params objectForKey:@"points"] stringValue];
    self.nameLabel.text = self.beer.name;
    self.ownerLabel.text = [self.params objectForKey:@"owner"];
    self.leagueLabel.text = [self.params objectForKey:@"leagueName"];
    self.numGloopsLabel.text = [NSString stringWithFormat:@"%ld Gloops!", (long)[actualUser.experiencePoints integerValue]];
    self.gloopsDoneLabel.text = [[NSString stringWithFormat:@"%ld Gloops! done", (long)[actualUser.experiencePoints integerValue]] uppercaseString];
    
    NSURL *url = [NSURL URLWithString:[BASE_URL stringByAppendingPathComponent:self.beer.beerImageURL]];
    [self.beerImage setImageWithURL:url];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.splashView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.splashView removeFromSuperview];
    }];
}


- (IBAction)showDescription:(UIButton *)sender {
    [sender removeFromSuperview];
    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@; color:rgb(255,247,155)}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body>%@</body> \n"
                                   "</html>",
                                   @"Helvetica",
                                   @(20),
                                   self.beer.beerInfo];
    [self.descriptionWebView loadHTMLString:myDescriptionHTML baseURL:nil];
}

- (IBAction)showDatos:(UIButton *)sender {
    [sender removeFromSuperview];
    [self.plusLabel2 setHidden:YES];
    self.featuresViewHeightConstraint.constant = 300;
    [self.scrollView setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.scrollView layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self.scrollView scrollRectToVisible:CGRectMake(self.featuresView.frame.origin.x, self.featuresView.frame.origin.y, self.featuresView.frame.size.width, self.featuresView.frame.size.height) animated:YES];
                     }];
}

#pragma mark - UIWebView Delegate Methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView.scrollView setScrollEnabled:NO];
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];

    [self.plusLabel setHidden:YES];
    self.descriptionViewHeightConstraint.constant += fittingSize.height;
    [self.scrollView setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.scrollView layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         [self.scrollView scrollRectToVisible:CGRectMake(self.descriptionView.frame.origin.x, self.descriptionView.frame.origin.y, self.descriptionView.frame.size.width, self.descriptionView.frame.size.height) animated:YES];
                     }];
    
}


#pragma mark - Navigation

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)websiteButtonPressed:(UIButton *)sender {
        //[[UIApplication sharedApplication] openURL:self.beer.brandURL];
}


@end
