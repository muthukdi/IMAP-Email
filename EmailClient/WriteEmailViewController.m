//
//  WriteEmailViewController.m
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WriteEmailViewController.h"

@implementation WriteEmailViewController
@synthesize toField = _toField;
@synthesize subjectField = _subjectField;
@synthesize doneButtonBar = _doneButtonBar;
@synthesize textView = _textView;

- (void)viewDidLoad
{
    [self.doneButtonBar setHidden:YES];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    [self textViewDidEndEditing:self.textView];
}

- (IBAction)homeButtonPressed:(id)sender
{
    if ([self.subjectField.text isEqualToString:@""] &&
        [self.toField.text isEqualToString:@""] &&
        [self.textView.text isEqualToString:@""])
    {
        [self performSegueWithIdentifier:@"writeToHome" sender:self];
    }
    else
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Message not complete!" message:@"Send message first or clear all fields before leaving." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message show];
    }
}
- (IBAction)dismissTextFieldKeyboard:(UITextField *)sender
{
    [sender resignFirstResponder];
}
- (void)moveViewUpWhileEditing
{
    CGRect rectangle = self.view.frame;
    rectangle.origin = CGPointMake(0,-190);
    self.view.frame = rectangle;
}
- (void)moveViewDownAfterEditing
{
    CGRect rectangle = self.view.frame;
    rectangle.origin = CGPointMake(0,20);
    self.view.frame = rectangle;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.doneButtonBar setHidden:NO];
    [self moveViewUpWhileEditing];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.textView resignFirstResponder];
    [self.doneButtonBar setHidden:YES];
    [self moveViewDownAfterEditing];
}

@end
