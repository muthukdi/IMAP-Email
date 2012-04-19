//
//  VaildationRoutines.m
//  EmailClient
//
//  Created by Dilip Muthukrishnan on 12-03-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VaildationRoutines.h"

@implementation ValidationRoutines

{
    NSString *domainAddressType;
}

// This method uses an open-source regex implementation to validate email address strings.  Addresses are validated in compliance with RFC 2822 specifications.
- (BOOL)validateEmailAddress:(NSString *)address
{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    BOOL result = [regExPredicate evaluateWithObject:address];
    return result;
}

// This method uses regex to validate a server domain string.
- (BOOL)validateServerNameUsingRegex:(NSString *)address
{
    NSString *serverRegEx = @"^[a-z0-9]+([-.]{1}[a-z0-9]+)*[.][a-z]{2,5}$";
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", serverRegEx];
    BOOL result = [regExPredicate evaluateWithObject:address];
    return result;
}

// This method uses SimplePingHelper to validate a server domain string via a ping test.
- (void)validateServerNameUsingPing:(NSString *)address withType:(NSString *)addressType
{
    domainAddressType = addressType;
    [SimplePingHelper ping:address target:self sel:@selector(pingResult:)];
}

// This method is required in order to use SimplePingHelper.
- (void)pingResult:(NSNumber *)success
{
    if (!success.boolValue)
    {
        if (validationResult == NO_ERROR)
        {
            if ([domainAddressType isEqualToString:@"IMAP"])
                validationResult = IMAP_SERVER_UNREACHABLE_ERROR;
            else if ([domainAddressType isEqualToString:@"SMTP"])
                validationResult = SMTP_SERVER_UNREACHABLE_ERROR;
        }
    }
}

@end