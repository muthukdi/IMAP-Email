//
//  WriteEmailViewController.h
//  EmailClient
//
//  This is the view controller for the "Write Mail" screen.
//
//  Created by Dilip Muthukrishnan on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmailClientModel.h"

@interface WriteEmailViewController : UIViewController <UITextViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextField *toField;
@property (weak, nonatomic) IBOutlet UINavigationBar *doneButtonBar;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) EmailClientModel *model;

- (IBAction)dismissTextFieldKeyboard:(UITextField *)sender;
- (void)moveViewUpWhileEditing;
- (void)moveViewDownAfterEditing;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)homeButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)sendButtonPressed:(UIBarButtonItem *)sender;

@end
