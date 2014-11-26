//
//  SignUpVC.h
//  ARApp
//
//  Created by Pau Ballart Godoy on 21/10/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpVC : UIViewController
- (IBAction)signUpButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *name_su_TF;
@property (weak, nonatomic) IBOutlet UITextField *email_su_TF;
@property (weak, nonatomic) IBOutlet UITextField *password_su_TF;


@end
