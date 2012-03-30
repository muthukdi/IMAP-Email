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

@interface ValidationRoutines: NSObject

- (BOOL)validateEmailAddress:(NSString *)address;
- (BOOL)validateServerNameUsingRegex:(NSString *)address;
- (BOOL)validateServerNameUsingDHCP:(NSString *)address;
- (void)validateServerNameUsingPing:(NSString *)address;
- (void)pingResult:(NSNumber *)success;

@end