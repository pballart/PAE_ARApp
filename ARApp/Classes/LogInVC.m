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

@interface LogInVC () <UITextFieldDelegate,UIScrollViewAccessibilityDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView2;


@end

@implementation LogInVC
CGPoint svos2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    //self.emailTF.text = @"proves@coreloparte.com";
    //self.passwordTF.text = @"hoPetem";
    
    [self.emailTF becomeFirstResponder];
    //[self.passwordTF nextResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard {
    [self.emailTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (IBAction)logInButtonPressed:(UIButton *)sender {
    [SVProgressHUD show];
    [[DataSource sharedDataSource] logInWithEmail:self.emailTF.text andPassword:self.passwordTF.text completion:^(NSDictionary *dict, NSError *error) {
        [SVProgressHUD dismiss];
        if (!error) {
            User *user = [[User alloc] initUserWithDictionary:dict];
            [self userDidLogIn:user];
            NSLog(@"Logged in!");
        } else {
            NSLog(@"Error logging in: %@", error);
        }
    }];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)userDidLogIn:(User *)user {
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

    
    svos2 = self.scrollView2.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.scrollView2];
    
    if (textField == self.emailTF) {
        
    }else if (textField == self.passwordTF) {
        //pt = rc.origin;
        pt.x = 0;
        pt.y += 60;
        //[self logInButtonPressed:nil];
    }
     [self.scrollView2 setContentOffset:pt animated:YES];
    

}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    CGPoint pt;
    pt.x = 0;
    pt.y =0;
    [self.scrollView2 setContentOffset:pt animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
