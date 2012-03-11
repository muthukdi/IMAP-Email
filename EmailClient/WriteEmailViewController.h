//
//  WriteEmailViewController.h
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteEmailViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextField *toField;
@property (weak, nonatomic) IBOutlet UINavigationBar *doneButtonBar;
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)dismissTextFieldKeyboard:(UITextField *)sender;
- (void)moveViewUpWhileEditing;
- (void)moveViewDownAfterEditing;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)homeButtonPressed:(UIBarButtonItem *)sender;

@end
