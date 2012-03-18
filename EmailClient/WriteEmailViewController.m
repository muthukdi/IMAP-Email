//
//  WriteEmailViewController.m
//  EmailClient
//
//  Created by Dilip Muthukrishnan on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WriteEmailViewController.h"

@implementation WriteEmailViewController
@synthesize toField = _toField;
@synthesize subjectField = _subjectField;
@synthesize doneButtonBar = _doneButtonBar;
@synthesize textView = _textView;
@synthesize model = _model;

// This method ensures that the "Done" button panel is not visible at the start.
- (void)viewDidLoad
{
    [self.doneButtonBar setHidden:YES];
}

// This code creates a model object and returns a reference to it.
- (EmailClientModel *)model
{
    if (_model)
        return _model;
    else
    {
        _model = [[EmailClientModel alloc] init];
        return _model;
    }
}

// This method simply calls the text view's delegate method in response to the "Done" button.
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    [self textViewDidEndEditing:self.textView];
}

// This method pops up a confirm dialog (if the message is incomplete) before returning to the Home Page.
- (IBAction)homeButtonPressed:(UIBarButtonItem *)sender
{
    self.subjectField.text = [self.subjectField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.toField.text = [self.toField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.textView.text = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([self.subjectField.text isEqualToString:@""] &&
        [self.toField.text isEqualToString:@""] &&
        [self.textView.text isEqualToString:@""])
    {
        [self performSegueWithIdentifier:@"writeToHome" sender:self];
    }
    else
    {
        UIAlertView *confirmBox = [[UIAlertView alloc] initWithTitle:@"Message not complete!" message:@"Do you want to discard the current message?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes",nil];
        [confirmBox show];
    }
}

// This method requests validation of the message header first before sending the email.
- (IBAction)sendButtonPressed:(UIBarButtonItem *)sender
{
    self.subjectField.text = [self.subjectField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.toField.text = [self.toField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    UIAlertView *alertBox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    if ([self.subjectField.text isEqualToString:@""] ||
        [self.toField.text isEqualToString:@""])
    {
        alertBox.message = @"One of your header fields is empty!";
        [alertBox show];
        return;
    }
    BOOL isValid = [self.model isEmailAddressValid:self.toField.text];
    if (!isValid)
    {
        alertBox.message = @"The email address you entered has the wrong format.";
        [alertBox show];
    }
}

// This method dismisses the keyboard once the user has finished editing the header fields.
- (IBAction)dismissTextFieldKeyboard:(UITextField *)sender
{
    sender.text = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [sender resignFirstResponder];
}

// This method moves the view up while the user is editing the text view.
- (void)moveViewUpWhileEditing
{
    CGRect rectangle = self.view.frame;
    rectangle.origin = CGPointMake(0,-190);
    self.view.frame = rectangle;
}

// This method moves the view back down after the user has finished editing the text view.
- (void)moveViewDownAfterEditing
{
    CGRect rectangle = self.view.frame;
    rectangle.origin = CGPointMake(0,20);
    self.view.frame = rectangle;
}

// This method shows the "done" button while the user is editing the text view.
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.doneButtonBar setHidden:NO];
    [self moveViewUpWhileEditing];
}

// This method dismisses the keyboard after user has finished editing the text view.
- (void)textViewDidEndEditing:(UITextView *)textView
{
    textView.text = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [textView resignFirstResponder];
    [self.doneButtonBar setHidden:YES];
    [self moveViewDownAfterEditing];
}

// This method is called when the user wishes to discard the current message and exit.
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        self.subjectField.text = @"";
        self.toField.text = @"";
        self.textView.text = @"";
        [self performSegueWithIdentifier:@"writeToHome" sender:self];
    }
}

@end
