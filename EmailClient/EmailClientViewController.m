//
//  EmailClientViewController.m
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailClientViewController.h"

@implementation EmailClientViewController
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize IMAPserver = _IMAPserver;
@synthesize IMAPport = _IMAPport;
@synthesize SMTPserver = _SMTPserver;
@synthesize SMTPport = _SMTPport;
@synthesize model = _model;

- (void) viewDidAppear:(BOOL)animated
{
    if (configDataExists)
    {
        [self performSegueWithIdentifier:@"configToHome" sender:self];
    }
    else
    {
        NSArray *entries = [self.model retrieveDataFromMemory];
        [self populateFieldsWithData:entries];
    }
}
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
- (void)populateFieldsWithData:(NSArray *)entries
{
    self.userName.text = [entries objectAtIndex:0];
    self.password.text = [entries objectAtIndex:1];
    self.IMAPserver.text = [entries objectAtIndex:2];
    self.IMAPport.text = [entries objectAtIndex:3];
    self.SMTPserver.text = [entries objectAtIndex:4];
    self.SMTPport.text = [entries objectAtIndex:5];
}
- (IBAction)dismissKeyboardOnEnterKey:(UITextField *)sender
{
    [sender resignFirstResponder];
}
- (IBAction)moveViewUpWhileEditing:(UITextField *)textField
{
    CGRect rectangle = self.view.frame; // does this only copy a pointer?
    rectangle.origin = CGPointMake(0,-190);
    self.view.frame = rectangle;
}
- (IBAction)moveViewDownAfterEditing:(UITextField *)textField;
{
    CGRect rectangle = self.view.frame; // does this only copy a pointer?
    rectangle.origin = CGPointMake(0,20);
    self.view.frame = rectangle;
}
- (IBAction)clearPressed:(UIButton *)sender
{
    self.userName.text = @"";
    self.password.text = @"";
    self.IMAPserver.text = @"";
    self.IMAPport.text = @"";
    self.SMTPserver.text = @"";
    self.SMTPport.text = @"";
    [self.model clearDataFromMemory];
}
- (IBAction)submitPressed:(UIButton *)sender
{
    NSArray *entries = [[NSArray alloc] initWithObjects:
                        self.userName.text,
                        self.password.text,
                        self.IMAPserver.text,
                        self.IMAPport.text,
                        self.SMTPserver.text,
                        self.SMTPport.text,
                        nil];
    BOOL valid = [self.model checkIfEntriesAreValid:entries];
    if (!valid)
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid Entries!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message show];
    }
    else
    {
        [self.model saveDataToMemory:entries];
        [self performSegueWithIdentifier:@"configToHome" sender:self];
    }
    
}

@end