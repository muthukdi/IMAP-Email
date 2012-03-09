//
//  EmailClientViewController.h
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmailClientModel.h"
#import "EmailClientAppDelegate.h"

@interface EmailClientViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *IMAPserver;
@property (weak, nonatomic) IBOutlet UITextField *IMAPport;
@property (weak, nonatomic) IBOutlet UITextField *SMTPserver;
@property (weak, nonatomic) IBOutlet UITextField *SMTPport;
@property (strong, nonatomic) EmailClientModel *model;

- (void)populateFieldsWithData:(NSArray *)entries;
- (IBAction)dismissKeyboardOnEnterKey:(UITextField *)sender;
- (IBAction)moveViewUpWhileEditing:(UITextField *)textField;
- (IBAction)moveViewDownAfterEditing:(UITextField *)textField;
- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)submitPressed:(UIButton *)sender;

@end
