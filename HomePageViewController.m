//
//  HomePageViewController.m
//  EmailClient
//
//  Created by PointerWare Laptop 4 on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomePageViewController.h"

@implementation HomePageViewController

- (IBAction)configPressed:(UIButton *)sender
{
    configEditMode = YES;
    [self performSegueWithIdentifier:@"homeToConfig" sender:self];
}
@end
