//
//  SettingsTVC.m
//  ARApp
//
//  Created by Albert Camps Oller on 09/11/14.
//  Copyright (c) 2014 SolArt Apps. All rights reserved.
//

#import "SettingsTVC.h"
#import <MessageUI/MessageUI.h>

#define facebook @"fb://requests"
#define appleStore @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=284417350&mt=8&uo=6"
#define webpage @"http://147.83.39.196/gloop/admin/templates/frontend/"

@interface SettingsTVC () <MFMailComposeViewControllerDelegate>


@end

@implementation SettingsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if ([selectedCell.reuseIdentifier isEqualToString:@"Invita"]){
        NSLog(@"Invita");
        [self abrirMail];
    }
    else if ([selectedCell.reuseIdentifier isEqualToString:@"Enviar"]){
        NSLog(@"Enviar");
        [self abrirMail];
    }
    else if ([selectedCell.reuseIdentifier isEqualToString:@"Reseña"]){
        NSURL *url = [NSURL URLWithString:appleStore];
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"Reseña");
    }
    else if ([selectedCell.reuseIdentifier isEqualToString:@"Legal"]){
        NSLog(@"Legal");
    }
    else if ([selectedCell.reuseIdentifier isEqualToString:@"Web"]){
        NSURL *url = [NSURL URLWithString:webpage];
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"Web");
    }
    else if ([selectedCell.reuseIdentifier isEqualToString:@"Facebook"]){
        NSURL *url = [NSURL URLWithString:facebook];
        [[UIApplication sharedApplication] openURL:url];
        NSLog(@"Facebook");
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"Exit");
    }
}

- (IBAction)abrirMail {
    
    // Comprobamos si nuestro dispositivo puede enviar mails en este momento
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Asunto del mensaje"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"usuario1@gmail.com", nil];
        
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"Texto que incluirá el <b>email</b> que vamos a enviar.";
        
        [mailer setMessageBody:emailBody isHTML:YES];
        
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Tu dispositivo no permite enviar correos desde esta app."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"El usuario ha cancelado el envio del email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"El usuario ha guardado el mensaje.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"El usuario ha enviado el mensaje y ha quedado pendiente.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"El mensaje no se ha guardado ni enviado por algún error.");
            break;
        default:
            NSLog(@"El mensaje no se ha enviado.");
            break;
    }
    // Eliminamos el controlador que muestra el envio del correo
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
