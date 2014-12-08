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
#import "DataSource.h"
#import "WebVC.h"

@interface BeerVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *splashView;
@property (weak, nonatomic) IBOutlet UILabel *earnedPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *becomesOwnerLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@property (weak, nonatomic) IBOutlet UIImageView *beerBannerImage;
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
@property (weak, nonatomic) IBOutlet UIWebView *featuresWebView;
@property (nonatomic, assign) BOOL descriptionIsShown;
@property (nonatomic, assign) BOOL featuresAreShown;


@end

@implementation BeerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.descriptionIsShown = NO;
    self.featuresAreShown = NO;
    
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
        //TODO: Change league
        //0 si no change i objecte lliga
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
    if (!self.beer) {
        self.beer = [[Beer alloc] initBeerWithDictionary:[self.params objectForKey:@"birra"]];
    }
    
    //Load info from owner
    [[DataSource sharedDataSource] getOwnerInfoFromBeer:self.beer.beerId andLeague:actualUser.league.leagueId completion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
//            NSLog(@"Received response: %@", dict);
            NSString *name = [dict objectForKey:@"name"];
            if (![name isEqualToString:@""]) {
                self.ownerLabel.text = name;
            } else {
                self.ownerLabel.text = @"No owner";
            }
            NSString *points = [dict objectForKey:@"points"];
            if ([points integerValue] > 0) {
                self.numGloopsLabel.text = [NSString stringWithFormat:@"%ld Gloops!", (long)[points integerValue]];
            }
        }else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
    }];
    
    //Update user
    [[DataSource sharedDataSource] getUserWithIdentifier:actualUser.userId completion:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            User *user = [[User alloc] initUserWithDictionary:dict];
            ((AppDelegate *)[UIApplication sharedApplication].delegate).actualUser = user;
            
        } else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error.userInfo objectForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [alert show];
        }
    }];
    
    //Set the labels text
    self.earnedPointsLabel.text = [[self.params objectForKey:@"points"] stringValue];
    self.nameLabel.text = self.beer.name;
    
    self.leagueLabel.text = [self.params objectForKey:@"leagueName"];
    if (!self.leagueLabel.text) {
        self.leagueLabel.text = actualUser.league.name;
    }
    
    
    self.gloopsDoneLabel.text = [[NSString stringWithFormat:@"%ld Gloops! done", (long)[self.beer.beerPoints integerValue]] uppercaseString];
    
    NSURL *url = [NSURL URLWithString:[API_BASE_URL stringByAppendingPathComponent:self.beer.beerImageURL]];
    [self.beerImage setImageWithURL:url];
    url = [NSURL URLWithString:[API_BASE_URL stringByAppendingPathComponent:self.beer.beerBannerURL]];
    [self.beerBannerImage setImageWithURL:url];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
    if (!self.descriptionIsShown) {
        self.descriptionIsShown = YES;
        [self.plusLabel setText:@"-"];
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
    else {
        self.descriptionIsShown = NO;
        [self.plusLabel setText:@"+"];
        self.descriptionViewHeightConstraint.constant = 66;
        [self.scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.scrollView layoutIfNeeded];
                         } completion:^(BOOL finished) {
//                             [self.scrollView scrollRectToVisible:CGRectMake(self.descriptionView.frame.origin.x, self.descriptionView.frame.origin.y, self.descriptionView.frame.size.width, self.descriptionView.frame.size.height) animated:YES];
                         }];
    }
}

- (IBAction)showDatos:(UIButton *)sender {
    if (!self.featuresAreShown) {
        self.featuresAreShown = YES;
        [self.plusLabel2 setText:@"-"];
        NSString *alcohol;
        if ([self.beer.alcohol isEqual:@-1]) {
            alcohol = @"We do not have this information";
        } else {
            alcohol = [NSString stringWithFormat:@"%@ %%", self.beer.alcohol];
        }
        NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                       "<head> \n"
                                       "<style type=\"text/css\"> \n"
                                       "body {font-family: \"%@\"; font-size: %@; color:rgb(255,247,155)}\n"
                                       "</style> \n"
                                       "</head> \n"
                                       "<body>"
                                       "<p><b>- Alcohol:</b> %@</p>"
                                       "<p><b>- Colour:</b> %@</p>"
                                       "<p><b>- Fermentation:</b> %@</p>"
                                       "<p><b>- Ingredients:</b> %@</p>"
                                       "<p><b>- Type:</b> %@</p>"
                                       "</body> \n"
                                       "</html>",
                                       @"Helvetica",
                                       @(20),
                                       alcohol, self.beer.colour, self.beer.fermentation, self.beer.ingredients, self.beer.type];
        [self.featuresWebView loadHTMLString:myDescriptionHTML baseURL:nil];

    } else {
        self.featuresAreShown = NO;
        [self.plusLabel2 setText:@"+"];
        self.featuresViewHeightConstraint.constant = 66;
        [self.scrollView setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.5
                         animations:^{
                             [self.scrollView layoutIfNeeded];
                         } completion:^(BOOL finished) {
//                             [self.scrollView scrollRectToVisible:CGRectMake(self.featuresView.frame.origin.x, self.featuresView.frame.origin.y, self.featuresView.frame.size.width, self.featuresView.frame.size.height) animated:YES];
                         }];

    }
}

#pragma mark - UIWebView Delegate Methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView.scrollView setScrollEnabled:NO];
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];

    if ([webView isEqual:self.descriptionWebView]) {
        self.descriptionViewHeightConstraint.constant += fittingSize.height;
    } else {
        self.featuresViewHeightConstraint.constant += fittingSize.height;
    }
    
    [self.scrollView setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.scrollView layoutIfNeeded];
                     } completion:^(BOOL finished) {
//                         [self.scrollView scrollRectToVisible:CGRectMake(self.descriptionView.frame.origin.x, self.descriptionView.frame.origin.y, self.descriptionView.frame.size.width, self.descriptionView.frame.size.height) animated:YES];
                     }];
    
}


#pragma mark - Navigation

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)websiteButtonPressed:(UIButton *)sender {
    WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
    webViewVC.url = self.beer.website;
    [self presentViewController:webViewVC animated:YES completion:nil];
}


@end
