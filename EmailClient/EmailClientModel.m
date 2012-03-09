//
//  EmailClientModel.m
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailClientModel.h"

@implementation EmailClientModel

@synthesize keychainItem = _keychainItem;

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
- (void)saveDataToMemory:(NSArray *)entries
{
    [self.keychainItem setObject:[entries objectAtIndex:0] forKey:(__bridge id)kSecAttrAccount];
    [self.keychainItem setObject:[entries objectAtIndex:1] forKey:(__bridge id)kSecValueData];
    [self.keychainItem setObject:[entries objectAtIndex:2] forKey:(__bridge id)kSecAttrDescription];
    [self.keychainItem setObject:[entries objectAtIndex:3] forKey:(__bridge id)kSecAttrLabel];
    [self.keychainItem setObject:[entries objectAtIndex:4] forKey:(__bridge id)kSecAttrType];
    [self.keychainItem setObject:[entries objectAtIndex:5] forKey:(__bridge id)kSecAttrComment];
}
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
- (void)clearDataFromMemory
{
    [self.keychainItem resetKeychainItem];
}
- (BOOL)checkIfEntriesAreValid:(NSArray *)entries
{
    for (NSString *entry in entries)
    {
        if ([entry isEqualToString:@""])
            return NO;
    }
    if ([[entries objectAtIndex:3] intValue] == 0)
        return NO;
    else if ([[entries objectAtIndex:5] intValue] == 0)
        return NO;
    else
        return YES;
}

@end
