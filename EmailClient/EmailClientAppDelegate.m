//
//  EmailClientAppDelegate.m
//  EmailClient
//
//  Created by Dilip Muthukrishnan on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmailClientAppDelegate.h"

@implementation EmailClientAppDelegate

@synthesize window = _window;
@synthesize model = _model;

// This method initializes the global flag variables that will help control the behavior
// of the configuration screen when it loads each time.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //sleep(1);
    configDataExists = NO;
    configEditMode = NO;
    NSArray *entries = [self.model retrieveDataFromMemory];
    for (NSString *item in entries)
    {
        if ([item isEqualToString:@""])
            return YES;
    }
    configDataExists = YES;
    return YES;
}

// This code creates a model object and returns a reference to it.
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

@end