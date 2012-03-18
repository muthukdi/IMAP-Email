//
//  EmailClientViewController.h
//  EmailClient
//
//  This is the initial view controller for the application.  It controls the configuration screen.
//
//  Created by PointerWare Laptop 4 on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmailClientModel.h"
#import "EmailClientAppDelegate.h"

@interface EmailClientViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *IMAPserver;
@property (weak, nonatomic) IBOutlet UITextField *IMAPport;
@property (weak, nonatomic) IBOutlet UITextField *SMTPserver;
@property (weak, nonatomic) IBOutlet UITextField *SMTPport;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearOrRestoreButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitOrUpdateButton;
@property (strong, nonatomic) EmailClientModel *model;

- (void)populateFieldsWithData:(NSArray *)entries;
- (IBAction)dismissTextFieldKeyboard:(UITextField *)sender;
- (IBAction)moveViewUpWhileEditing:(UITextField *)textField;
- (IBAction)moveViewDownAfterEditing:(UITextField *)textField;
- (IBAction)submitOrUpdatePressed:(UIBarButtonItem *)sender;
- (IBAction)clearOrRestorePressed:(UIBarButtonItem *)sender;

/***** This method is just for debugging purposes! *****/
- (IBAction)clearButtonPressed:(UIButton *)sender;

@end
