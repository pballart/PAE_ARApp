//
//  SignUpVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 21/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "SignUpVC.h"
#import "DataSource.h"
#import "PageContentVC.h"
#import "User.h"
#import "AppDelegate.h"
#import "Configuration.h"
#import <SVProgressHUD/SVProgressHUD.h>


@interface SignUpVC ()  <UITextFieldDelegate,UIScrollViewAccessibilityDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.name_su_TF.leftView = paddingView;
    self.email_su_TF.leftView = paddingView2;
    self.password_su_TF.leftView = paddingView3;
    self.name_su_TF.leftViewMode = UITextFieldViewModeAlways;
    self.email_su_TF.leftViewMode = UITextFieldViewModeAlways;
    self.password_su_TF.leftViewMode = UITextFieldViewModeAlways;
    
    //[self.name_su_TF becomeFirstResponder];
    
}

-(void) dismissKeyboard {
    [self.name_su_TF resignFirstResponder];
    [self.password_su_TF resignFirstResponder];
    [self.email_su_TF resignFirstResponder];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)signUpButtonPressed:(id)sender {
    
    [SVProgressHUD show];
    [[DataSource sharedDataSource] signInWithEmail:self.email_su_TF.text name:self.name_su_TF.text andPassword:self.password_su_TF.text completion:^(NSDictionary *dict, NSError *error){
        [SVProgressHUD dismiss];
        if (!error) {
            User *user = [[User alloc] initUserWithDictionary:dict];
            [self userDidLogIn:user];
            NSLog(@"Signed up and logged in!");
        } else {
            NSLog(@"Error signing up: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error signing up" message:[NSString stringWithFormat:@"User may already exist. Also check that password has minimum 6 characters"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }];

}

-(void)userDidLogIn:(User *)user {
    [(AppDelegate *)[UIApplication sharedApplication].delegate setActualUser:user];
    PageContentVC *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self.navigationController presentViewController:VC animated:YES completion:nil];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    if (textField == self.name_su_TF) {
        [self.email_su_TF becomeFirstResponder];
    } else if (textField == self.email_su_TF) {
        [self.email_su_TF resignFirstResponder];
        [self.password_su_TF becomeFirstResponder];
    }    else if (textField == self.password_su_TF) {
        [self.password_su_TF resignFirstResponder];
        [self signUpButtonPressed:nil];
    }
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.name_su_TF) {
        [self.scrollView setContentOffset:CGPointMake(0, 10) animated:YES];
    } else if (textField == self.email_su_TF) {
        [self.scrollView setContentOffset:CGPointMake(0, 60) animated:YES];
    } else if (textField == self.password_su_TF) {
        [self.scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
 }
-(void) textFieldDidEndEditing:(UITextField *)textField{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)openTermsWebsite:(id)sender {
    
}

@end
