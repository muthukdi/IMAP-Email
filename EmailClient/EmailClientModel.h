//
//  EmailClientModel.h
//  EmailClient
//
//  This is the "model" for the application.  Its primary function is to store and manipulate data
//  that is used by the client and manage connections to the mail server.
//
//  Created by Dilip Muthukrishnan on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "VaildationRoutines.h"

@interface EmailClientModel : NSObject

@property (nonatomic, strong) KeychainItemWrapper *keychainItem;
@property (nonatomic, strong) ValidationRoutines *validator;

- (void)saveDataToMemory:(NSArray *)entries;
- (NSArray *)retrieveDataFromMemory;
- (void)clearDataFromMemory;
- (enum error)checkIfEntriesAreValid:(NSArray *)entries;
- (BOOL)isEmailAddressValid:(NSString *)address;

@end
