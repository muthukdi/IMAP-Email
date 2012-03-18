//
//  EmailClientAppDelegate.h
//  EmailClient
//
//  This is the Application Delegate class.  In addition to managing all setup operations for
//  the app, it also stores global flag variables that help view controllers talk to each other.
//
//  Created by Dilip Muthukrishnan on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmailClientModel.h"

BOOL configDataExists;
BOOL configEditMode;

@interface EmailClientAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) EmailClientModel *model;


@end
