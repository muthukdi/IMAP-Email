//
//  EmailClientModel.h
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "KeychainItemWrapper.h"

@interface EmailClientModel : NSObject

@property (nonatomic, strong) KeychainItemWrapper *keychainItem;

- (void)saveDataToMemory:(NSArray *)entries;
- (NSArray *)retrieveDataFromMemory;
- (void)clearDataFromMemory;
- (BOOL)checkIfEntriesAreValid:(NSArray *)entries;

@end
