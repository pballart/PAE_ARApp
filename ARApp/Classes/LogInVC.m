//
//  LogInVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 21/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "LogInVC.h"
#import "DataSource.h"
#import "PageContentVC.h"
#import "User.h"
#import "AppDelegate.h"
#import "Configuration.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "WebVC.h"

@interface LogInVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView2;
@property (weak, nonatomic) IBOutlet UIView *credentialsView;


@end

@implementation LogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
//    self.emailTF.text = @"pau@takeagloop.com";
//    self.passwordTF.text = @"ioslopeta";
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.emailTF.leftView = paddingView;
    self.passwordTF.leftView = paddingView2;
    self.emailTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    
    //[self.emailTF becomeFirstResponder];
    
}


-(void) dismissKeyboard {
    [self.emailTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (IBAction)logInButtonPressed:(UIButton *)sender {
    [SVProgressHUD show];
    [[DataSource sharedDataSource] logInWithEmail:self.emailTF.text andPassword:self.passwordTF.text completion:^(NSDictionary *dict, NSError *error) {
        
        if (!error) {
            User *user = [[User alloc] initUserWithDictionary:dict];
            [self userDidLogIn:user];
            NSLog(@"Logged in!");
        } else {
            NSLog(@"Error logging in: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error logging in" message:[NSString stringWithFormat:@"Please make sure your credentials are correct"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)userDidLogIn:(User *)user {
    [SVProgressHUD dismiss];
    [(AppDelegate *)[UIApplication sharedApplication].delegate setActualUser:user];
    PageContentVC *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self.navigationController presentViewController:VC animated:YES completion:nil];
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTF) {
        [self.passwordTF becomeFirstResponder];
    } else if (textField == self.passwordTF) {
        [self.passwordTF resignFirstResponder];
        [self logInButtonPressed:nil];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.emailTF) {
        [self.scrollView2 setContentOffset:CGPointMake(0, 10) animated:YES];
    }else if (textField == self.passwordTF) {
        [self.scrollView2 setContentOffset:CGPointMake(0, 60) animated:YES];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    [self.scrollView2 setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - Navigation

- (IBAction)openResetPasswordURL:(id)sender {
    WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
    webViewVC.url = @"http://www.takeagloop.com/recovery";
    [self presentViewController:webViewVC animated:YES completion:nil];
}

@end
