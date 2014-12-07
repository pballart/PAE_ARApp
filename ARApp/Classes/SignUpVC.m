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
#import "WebVC.h"


@interface SignUpVC ()  <UITextFieldDelegate,UIScrollViewAccessibilityDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *birthDate;

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
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.name_su_TF.leftView = paddingView;
    self.email_su_TF.leftView = paddingView2;
    self.password_su_TF.leftView = paddingView3;
    self.birthdayTextField.leftView = paddingView4;
    self.name_su_TF.leftViewMode = UITextFieldViewModeAlways;
    self.email_su_TF.leftViewMode = UITextFieldViewModeAlways;
    self.password_su_TF.leftViewMode = UITextFieldViewModeAlways;
    self.birthdayTextField.leftViewMode = UITextFieldViewModeAlways;
    [self initializeTextFieldInputView];
    
}

- (void) initializeTextFieldInputView {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minuteInterval = 5;
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    self.birthdayTextField.inputView = datePicker;
}

- (void) dateUpdated:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    self.birthdayTextField.text = [formatter stringFromDate:datePicker.date];
    self.birthDate = datePicker.date;
}

-(void) dismissKeyboard {
    [self.name_su_TF resignFirstResponder];
    [self.password_su_TF resignFirstResponder];
    [self.email_su_TF resignFirstResponder];
    [self.birthdayTextField resignFirstResponder];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)signUpButtonPressed:(id)sender {
    
    [SVProgressHUD show];
    NSNumber *dinoTime = [NSNumber numberWithDouble:[self.birthDate timeIntervalSince1970]];
    NSNumber *gender = [NSNumber numberWithInteger:self.genderSegmentedControl.selectedSegmentIndex+1];
    [[DataSource sharedDataSource] signInWithEmail:self.email_su_TF.text name:self.name_su_TF.text birthday:dinoTime gender:gender andPassword:self.password_su_TF.text completion:^(NSDictionary *dict, NSError *error){
        [SVProgressHUD dismiss];
        if (!error) {
            User *user = [[User alloc] initUserWithDictionary:dict];
            [self userDidLogIn:user];
            NSLog(@"Signed up and logged in!");
        } else {
            NSLog(@"Error signing up: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error signing up" message:[NSString stringWithFormat:@"User may already exist. Also check that password has minimum 6 characters and that you are over legal age."] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }];

}

-(void)userDidLogIn:(User *)user {
    [SVProgressHUD dismiss];
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
    } else if (textField == self.password_su_TF) {
        [self.password_su_TF resignFirstResponder];
        [self.birthdayTextField becomeFirstResponder];
    } else if (textField == self.birthdayTextField) {
        [self.birthdayTextField resignFirstResponder];
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
    } else if (textField == self.birthdayTextField) {
        [self.scrollView setContentOffset:CGPointMake(0, 110) animated:YES];
    }
 }
-(void) textFieldDidEndEditing:(UITextField *)textField{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (IBAction)openTermsWebsite:(id)sender {
    WebVC *webViewVC = [[UIStoryboard storyboardWithName:@"Settings" bundle:nil] instantiateViewControllerWithIdentifier:@"WebVC"];
    webViewVC.url = @"http://www.takeagloop.com/tos";
    [self presentViewController:webViewVC animated:YES completion:nil];
}

@end
