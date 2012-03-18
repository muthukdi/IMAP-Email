//
//  HomePageViewController.m
//  EmailClient
//
//  Created by Dilip Muthukrishnan on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomePageViewController.h"

@implementation HomePageViewController

// This method simply takes the user back to the configuration screen in "Edit" mode.
- (IBAction)configPressed:(UIButton *)sender
{
    configEditMode = YES;
    [self performSegueWithIdentifier:@"homeToConfig" sender:self];
}
@end
