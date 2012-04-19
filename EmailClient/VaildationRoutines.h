//
//  VaildationRoutines.h
//  EmailClient
//  
//  This file contains a set of functions for email address and server domain
//  name validation.
//
//  Created by Dilip Muthukrishnan on 12-03-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimplePingHelper.h"

// An enum type declaring a specified list of errors
enum error {NO_ERROR,
            EMPTY_FIELD_ERROR,
            INTERNAL_WHITESPACE_ERROR,
            IMAP_SERVER_FORMAT_ERROR,
            IMAP_SERVER_UNREACHABLE_ERROR,
            IMAP_PORT_NUMBER_ERROR,
            SMTP_SERVER_FORMAT_ERROR,
            SMTP_SERVER_UNREACHABLE_ERROR,
            SMTP_PORT_NUMBER_ERROR};
enum error validationResult;

@interface ValidationRoutines: NSObject

- (BOOL)validateEmailAddress:(NSString *)address;
- (BOOL)validateServerNameUsingRegex:(NSString *)address;
- (void)validateServerNameUsingPing:(NSString *)address withType:(NSString *)addressType;
- (void)pingResult:(NSNumber *)success;

@end