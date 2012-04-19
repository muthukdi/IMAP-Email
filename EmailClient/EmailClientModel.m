//
//  EmailClientModel.m
//  EmailClient
//
//  Created by Dilip Muthukrishnan on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailClientModel.h"

@implementation EmailClientModel

@synthesize keychainItem = _keychainItem;
@synthesize validator = _validator;

// This code creates a keychain object and returns a reference to it.
- (KeychainItemWrapper *)keychainItem
{
    if (_keychainItem)
        return _keychainItem;
    else
    {
        _keychainItem = 
        [[KeychainItemWrapper alloc] initWithIdentifier:@"configData" accessGroup:nil];
        return _keychainItem;
    }
}

// This code creates a ValidationRoutines object and returns a reference to it.
- (ValidationRoutines *)validator
{
    if (_validator)
        return _validator;
    else
        return [[ValidationRoutines alloc] init];
}

// This code saves each string to the keychain using key constants.
- (void)saveDataToMemory:(NSArray *)entries
{
    [self.keychainItem setObject:[entries objectAtIndex:0] forKey:(__bridge id)kSecAttrAccount];
    [self.keychainItem setObject:[entries objectAtIndex:1] forKey:(__bridge id)kSecValueData];
    [self.keychainItem setObject:[entries objectAtIndex:2] forKey:(__bridge id)kSecAttrDescription];
    [self.keychainItem setObject:[entries objectAtIndex:3] forKey:(__bridge id)kSecAttrLabel];
    [self.keychainItem setObject:[entries objectAtIndex:4] forKey:(__bridge id)kSecAttrType];
    [self.keychainItem setObject:[entries objectAtIndex:5] forKey:(__bridge id)kSecAttrComment];
}

// This code retrieves string attributes from keychain and stores it in an array.
- (NSArray *)retrieveDataFromMemory
{
    NSArray *entries = [[NSArray alloc] initWithObjects:
                        [self.keychainItem objectForKey:(__bridge id)kSecAttrAccount],
                        [self.keychainItem objectForKey:(__bridge id)kSecValueData],
                        [self.keychainItem objectForKey:(__bridge id)kSecAttrDescription],
                        [self.keychainItem objectForKey:(__bridge id)kSecAttrLabel],
                        [self.keychainItem objectForKey:(__bridge id)kSecAttrType],
                        [self.keychainItem objectForKey:(__bridge id)kSecAttrComment],
                        nil];
    return entries;
}

// This method clears data from keychain but does NOT delete the keychain itself.
- (void)clearDataFromMemory
{
    [self.keychainItem resetKeychainItem];
}

// This method uses regex patterns to validate configuration form input.
- (enum error)checkIfEntriesAreValid:(NSArray *)entries
{
    NSString *pattern;
    NSRegularExpression *regex;
    NSUInteger matches = 0;
    // First, look for empty fields.
    for (NSString *entry in entries)
    {
        if ([entry isEqualToString:@""])
            return EMPTY_FIELD_ERROR;
    }
    // Second, look for internal whitespaces using this pattern.
    pattern = @"[ \t]";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    for (NSString *entry in entries)
    {
        matches = [regex numberOfMatchesInString:entry options:0 range:NSMakeRange(0,entry.length)];
        if (matches > 0)
            return INTERNAL_WHITESPACE_ERROR;
    }
    // Third, check that the IMAP server has the correct format using this pattern.
    NSString *imapserver = [entries objectAtIndex:2];
    BOOL result = [self.validator validateServerNameUsingRegex:imapserver];
    if (!result)
        return IMAP_SERVER_FORMAT_ERROR;
    // Fourth, check that the IMAP port has no more than four digits using this pattern.
    pattern = @"^[0-9]{1,4}$";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSString *imapport = [entries objectAtIndex:3];
    matches = [regex numberOfMatchesInString:imapport options:0 range:NSMakeRange(0,imapport.length)];
    if (matches == 0)
        return IMAP_PORT_NUMBER_ERROR;
    // Fifth, check that the SMTP server has the correct format using this pattern.
    NSString *smtpserver = [entries objectAtIndex:4];
    result = [self.validator validateServerNameUsingRegex:smtpserver];
    if (!result)
        return SMTP_SERVER_FORMAT_ERROR;
    // Lastly, check that the SMTP port has no more than four digits using this pattern.
    pattern = @"^[0-9]{1,4}$";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSString *smtpport = [entries objectAtIndex:5];
    matches = [regex numberOfMatchesInString:smtpport options:0 range:NSMakeRange(0,smtpport.length)];
    if (matches == 0)
        return SMTP_PORT_NUMBER_ERROR;
    // Everything looks good, so validation successful!
    return NO_ERROR;
}

// This method uses regex to validate email addresses.
- (BOOL)isEmailAddressValid:(NSString *)address
{
    return [self.validator validateEmailAddress:address];
}

@end
