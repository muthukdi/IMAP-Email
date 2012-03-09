//
//  EmailClientAppDelegate.m
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailClientAppDelegate.h"

@implementation EmailClientAppDelegate

@synthesize window = _window;
@synthesize model = _model;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //sleep(1);
    configDataExists = NO;
    NSLog(@"%d",configDataExists);
    NSArray *entries = [self.model retrieveDataFromMemory];
    for (NSString *entry in entries)
    {
        if ([entry isEqualToString:@""])
            return YES;
    }
    configDataExists = YES;
    return YES;
}

@end