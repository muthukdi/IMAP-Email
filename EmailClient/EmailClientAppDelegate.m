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