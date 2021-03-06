//
//  EmailClientViewController.m
//  EmailClient
//
//  Created by Dilip Muthukrishnan on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailClientViewController.h"

@implementation EmailClientViewController

{
    NSArray *fieldData;
}

@synthesize instructions = _instructions;
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize IMAPserver = _IMAPserver;
@synthesize IMAPport = _IMAPport;
@synthesize SMTPserver = _SMTPserver;
@synthesize SMTPport = _SMTPport;
@synthesize clearOrRestoreButton = _clearOrRestoreButton;
@synthesize submitOrUpdateButton = _submitOrUpdateButton;
@synthesize model = _model;

/* The code in this section controls the initial appearance and behavior of the
 configuration screen using globally defined flag variables. */
- (void) viewDidAppear:(BOOL)animated
{
    if (configDataExists)
    {
        if (configEditMode)
        {
            [self.view setAlpha:1.0];
            self.clearOrRestoreButton.title = @"Restore";
            self.submitOrUpdateButton.title = @"Update";
            NSArray *entries = [self.model retrieveDataFromMemory];
            [self populateFieldsWithData:entries];
        }
        else
        {
            [self.view setAlpha:0.0];
            [self performSegueWithIdentifier:@"configToHome" sender:self];
        }
    }
    else
    {
        [self.view setAlpha:1.0];
        self.clearOrRestoreButton.title = @"Clear";
        self.submitOrUpdateButton.title = @"Submit";
    }
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

// Displays existing form data in fields.
- (void)populateFieldsWithData:(NSArray *)entries
{
    self.userName.text = [entries objectAtIndex:0];
    self.password.text = [entries objectAtIndex:1];
    self.IMAPserver.text = [entries objectAtIndex:2];
    self.IMAPport.text = [entries objectAtIndex:3];
    self.SMTPserver.text = [entries objectAtIndex:4];
    self.SMTPport.text = [entries objectAtIndex:5];
}

// Trims whitespace from input and dismisses keyboard once user has finished editing.
- (IBAction)dismissTextFieldKeyboard:(UITextField *)sender
{
    sender.text = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [sender resignFirstResponder];
}

// Moves entire view 190 pixels upwards to make room for virtual keyboard.
- (IBAction)moveViewUpWhileEditing:(UITextField *)textField
{
    CGRect rectangle = self.view.frame; // does this only copy a pointer?
    rectangle.origin = CGPointMake(0,-190);
    self.view.frame = rectangle;
}

// Returns view to original position once keyboard has been dismissed.
- (IBAction)moveViewDownAfterEditing:(UITextField *)textField;
{
    CGRect rectangle = self.view.frame; // does this only copy a pointer?
    rectangle.origin = CGPointMake(0,20);
    self.view.frame = rectangle;
}

// Either clears or restores data from memory and outputs to text fields.
- (IBAction)clearOrRestorePressed:(UIBarButtonItem *)sender
{
    NSArray *entries;
    if ([self.clearOrRestoreButton.title isEqualToString:@"Clear"])
    {
        [self.model clearDataFromMemory];
        entries = [self.model retrieveDataFromMemory];
        [self populateFieldsWithData:entries];
    }
    else
    {
        entries = [self.model retrieveDataFromMemory];
        [self populateFieldsWithData:entries];
    }
}

/***** This method is just for debugging purposes! *****/
- (IBAction)clearButtonPressed:(UIButton *)sender
{
    [self.model clearDataFromMemory];
    NSArray *entries = [self.model retrieveDataFromMemory];
    [self populateFieldsWithData:entries];
}/*******************************************************/

// Validate form data using regex and PING routines
- (IBAction)submitOrUpdatePressed:(UIBarButtonItem *)sender
{
    [self.submitOrUpdateButton setEnabled:NO];
    // Store user's input (after trimming leading and trailing whitespaces) inside an array
    fieldData = [[NSArray alloc] initWithObjects:
                    [self.userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    [self.IMAPserver.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    [self.IMAPport.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    [self.SMTPserver.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    [self.SMTPport.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
                    nil];
    self.instructions.text = @"Please wait while we verify your information...";
    self.instructions.textColor = [UIColor blueColor];
    validationResult = [self.model checkIfEntriesAreValid:fieldData];
    [self.model.validator validateServerNameUsingPing:self.IMAPserver.text withType:@"IMAP"];
    [self.model.validator validateServerNameUsingPing:self.SMTPserver.text withType:@"SMTP"];
    [self performSelector:@selector(processErrorsAndSave) withObject:nil afterDelay:1.1];
}

// Display error messages after validation (if needed), or save data to memory.
- (void)processErrorsAndSave
{
    UIAlertView *alertBox;
    UIAlertView *confirmBox;
    [self.submitOrUpdateButton setEnabled:YES];
    self.instructions.text = @"Please provide your email configuration details here.";
    self.instructions.textColor = [UIColor blackColor];
    if (validationResult != NO_ERROR)
    {
        alertBox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        if (validationResult == EMPTY_FIELD_ERROR)
            alertBox.message = @"Some of your fields are empty!";
        else if (validationResult == INTERNAL_WHITESPACE_ERROR)
            alertBox.message = @"Your input values cannot contain spaces!";
        else if (validationResult == IMAP_SERVER_FORMAT_ERROR)
            alertBox.message = @"IMAP server has incorrect format!";
        else if (validationResult == IMAP_PORT_NUMBER_ERROR)
            alertBox.message = @"IMAP port number is incorrect!";
        else if (validationResult == SMTP_SERVER_FORMAT_ERROR)
            alertBox.message = @"SMTP server has incorrect format!";
        else if (validationResult == SMTP_PORT_NUMBER_ERROR)
            alertBox.message = @"SMTP port number is incorrect!";
        else if (validationResult == IMAP_SERVER_UNREACHABLE_ERROR)
            alertBox.message = @"IMAP server cannot be reached!";
        else if (validationResult == SMTP_SERVER_UNREACHABLE_ERROR)
            alertBox.message = @"SMTP server cannot be reached!";
        [alertBox show];
    }
    else
    {
        // Validation is successful. Ask user before saving data to memory and then go to Home Page.
        // UIAlertViewDelegate method performs saving and scene transition functions.
        confirmBox = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to submit?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes",nil];
        [confirmBox show];
    }
}

// This method handles events from the confirm dialog.  I had to move the saving and scene
// transition code from the previous method into this one to solve the "modal" problem.
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self.model saveDataToMemory:fieldData];
        configDataExists = YES;
        configEditMode = NO;
        [self performSegueWithIdentifier:@"configToHome" sender:self];
    }
}

@end