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


@interface SignUpVC ()

@end

@implementation SignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.name_su_TF.text = @"Name";
    self.password_su_TF.text = @"Password";
    self.email_su_TF.text = @"e-mail";
    
    
    
}

-(void) dismissKeyboard {
    [self.name_su_TF resignFirstResponder];
    [self.password_su_TF resignFirstResponder];
    [self.email_su_TF resignFirstResponder];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUpButtonPressed:(id)sender {
    
    [SVProgressHUD show];
    [[DataSource sharedDataSource] signInWithEmail:self.email_su_TF.text name:self.name_su_TF.text andPassword:self.password_su_TF.text completion:^(NSDictionary *dict, NSError *error){
       [SVProgressHUD dismiss];
        if (!error) {
            NSLog(@"Sign up seccessfull");
            BOOL valid = [self checkIfErrors:dict];
            if (valid) {
                User *user = [[User alloc] initUserWithDictionary:dict];
                [self userDidLogIn:user];
            }
            
        } else {
            NSLog(@"Error signing up in: %@", error);
        }
    }];

}

-(void)userDidLogIn:(User *)user {
    [(AppDelegate *)[UIApplication sharedApplication].delegate setActualUser:user];
    
    PageContentVC *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self.navigationController presentViewController:VC animated:YES completion:nil];
}

-(BOOL) checkIfErrors:(NSDictionary*)dict {
    NSInteger num = [[dict objectForKey:@"error"] integerValue];
    switch (num) {
        case 0:
        {
            return YES;
        }
            break;
        case 1:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Something went wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        case 2:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Something went wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        case 3:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Something went wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
        case 4:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ups..." message:@"Something went wrong" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
            break;
            
        default:
            return NO;
            break;
    }
}

@end
