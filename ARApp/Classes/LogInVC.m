//
//  LogInVC.m
//  ARApp
//
//  Created by Pau Ballart Godoy on 21/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "LogInVC.h"
#import "DataSource.h"
#import "ViewController.h"

@interface LogInVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.emailTF.text = @"plus.dimension@plus-dimension.com";
    self.passwordTF.text = @"1234567";
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
            NSLog(@"Logged in: %@", dict);
            [self userDidLogInWithIdentifier:[dict objectForKey:@"id"]];
        } else {
            NSLog(@"Error logging in: %@", error);
        }
    }];
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)userDidLogInWithIdentifier:(NSString *) identifier {
    [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:kUserLoggedInUserDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
    ViewController *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end