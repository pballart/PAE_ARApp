//
//  SettingsTVC.m
//  ARApp
//
//  Created by Albert Camps Oller on 09/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "SettingsTVC.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "WebVC.h"

#define FACEBOOK_GLOOP_PAGE @"http://www.facebook.com/takeagloop"
#define FACEBOOK_GLOOP_PAGE_URI @"fb://profile/992206174129331"
#define INSTAGRAM_GLOOP_PAGE @"http://www.instagram.com/takeagloop"
#define INSTAGRAM_GLOOP_PAGE_URI @"instagram://user?username=takeagloop"
#define APP_STORE_LINK @"https://itunes.apple.com/us/app/gloop!/id949189876"
#define GLOOP_WEBPAGE @"http://www.takeagloop.com"
#define FAQ_WEBPAGE @"http://www.takeagloop.com/faq"
#define TOS_WEBPAGE @"http://www.takeagloop.com/tos"
#define ABOUT_WEBPAGE @"http://www.takeagloop.com/about"

@interface SettingsTVC () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>


@end

@implementation SettingsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settings_background"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3]];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(25,0, 300, 50)];
    // label.backgroundColor = [UIColor yellowColor];
    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    label.textColor = [UIColor whiteColor];
    [headerView addSubview:label];
    if (section == 0){
        label.text=@"SUPPORT";
    }else if(section ==1 ){
        label.text=@"SOCIAL";
    }else if(section ==2 ){
        label.text=@"ABOUT GLOOP!";
    }else if(section ==3 ){
        label.text=@"LOGOUT";
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //FAQ
                    WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
                    webViewVC.url = FAQ_WEBPAGE;
                    [self presentViewController:webViewVC animated:YES completion:nil];
                }
                    break;
                case 1:
                    //Send feedback
                    [self sendFeedbackMail];
                    break;
                case 2:
                    //Make a review
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_STORE_LINK]];
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //Invite friends
                    if ([MFMessageComposeViewController canSendText]) {
                        MFMessageComposeViewController *smsVC = [[MFMessageComposeViewController alloc] init];
                        smsVC.messageComposeDelegate = self;
                        smsVC.body = [@"Hey! I know you like beers so you will like this new beer app 😜 Check it out! " stringByAppendingString:APP_STORE_LINK];
                        [self presentViewController:smsVC animated:YES completion:nil];
                    }
                }
                    break;
                case 1:
                    //facebook
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:FACEBOOK_GLOOP_PAGE_URI]]) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:FACEBOOK_GLOOP_PAGE_URI]];
                    } else {
                        WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
                        webViewVC.url = FACEBOOK_GLOOP_PAGE;
                        [self presentViewController:webViewVC animated:YES completion:nil];
                    }
                    break;
                case 2:
                    //instagram
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:INSTAGRAM_GLOOP_PAGE_URI]]) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:INSTAGRAM_GLOOP_PAGE_URI]];
                    } else {
                        WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
                        webViewVC.url = INSTAGRAM_GLOOP_PAGE;
                        [self presentViewController:webViewVC animated:YES completion:nil];
                    }
                    break;
                case 3:
                {
                    //website
                    WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
                    webViewVC.url = GLOOP_WEBPAGE;
                    [self presentViewController:webViewVC animated:YES completion:nil];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //terms of user
                    WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
                    webViewVC.url = TOS_WEBPAGE;
                    [self presentViewController:webViewVC animated:YES completion:nil];
                }
                    break;
                case 1:
                {
                    //about plusdimension
                    WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
                    webViewVC.url = ABOUT_WEBPAGE;
                    [self presentViewController:webViewVC animated:YES completion:nil];

                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            //Logout
            [self logout];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)sendFeedbackMail {
    
    // Comprobamos si nuestro dispositivo puede enviar mails en este momento
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Feedback from Gloop! app"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"support@takeagloop.com", nil];
        
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"I've been using the Gloop! app and I wanted you to know that...";
        
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You cannot send e-mails right now."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

-(void) logout {
    [((AppDelegate *)[UIApplication sharedApplication].delegate) resetWindowToInitialView];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
