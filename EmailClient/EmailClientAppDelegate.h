//
//  EmailClientAppDelegate.h
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-02-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmailClientModel.h"

BOOL configDataExists;

@interface EmailClientAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) EmailClientModel *model;


@end
