//
//  SingleWinnerViewController.m
//  Weatherby
//
//  Created by user2492 on 3/25/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "SingleWinnerViewController.h"

@implementation SingleWinnerViewController

@synthesize name;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@", name);
    self.title = name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
