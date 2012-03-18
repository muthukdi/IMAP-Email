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
- (int)checkIfEntriesAreValid:(NSArray *)entries
{
    NSString *pattern;
    NSRegularExpression *regex;
    NSUInteger matches = 0;
    // First, look for empty fields
    for (NSString *entry in entries)
    {
        if ([entry isEqualToString:@""])
            return 0;
    }
    // Second, look for internal whitespaces
    pattern = @"[ \t]";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    for (NSString *entry in entries)
    {
        matches = [regex numberOfMatchesInString:entry options:0 range:NSMakeRange(0,entry.length)];
        if (matches > 0)
            return 1;
    }
    // Third, check that the IMAP server has the correct format using this pattern
    pattern = @"^[a-zA-Z0-9]+[.][a-zA-Z0-9]+[.][a-zA-Z0-9]+$";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSString *imapserver = [entries objectAtIndex:2];
    matches = [regex numberOfMatchesInString:imapserver options:0 range:NSMakeRange(0,imapserver.length)];
    if (matches == 0)
        return 2;
    // Fourth, check that the IMAP port = 143
    if ([[entries objectAtIndex:3] intValue] != 143)
        return 3;
    // Fifth, check that the SMTP server has the correct format using the previously saved pattern
    NSString *smtpserver = [entries objectAtIndex:4];
    matches = [regex numberOfMatchesInString:smtpserver options:0 range:NSMakeRange(0,smtpserver.length)];
    if (matches == 0)
        return 4;
    // Lastly, check that the SMTP port = 25
    if ([[entries objectAtIndex:5] intValue] != 25)
        return 5;
    // Everything looks good, so validation successful!
    return 6;
}

// This method uses regex to validate the "Write Mail" email address.
- (BOOL)isEmailAddressValid:(NSString *)address
{
    NSString *pattern = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+[.][A-Za-z]{2,4}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSUInteger matches = [regex numberOfMatchesInString:address options:0 range:NSMakeRange(0,address.length)];
    if (matches == 0)
        return NO;
    else
        return YES;
}

@end
