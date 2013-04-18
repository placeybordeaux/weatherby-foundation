//
//  SingleEffortViewController.m
//  Weatherby
//
//  Created by user2492 on 3/25/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "SingleEffortViewController.h"

@implementation SingleEffortViewController

@synthesize title_info;
@synthesize labelField;
@synthesize state;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = title_info;
    
    // Read content from local file
    NSString *fp = [[NSBundle mainBundle] pathForResource:@"Efforts" ofType:@"txt" inDirectory:nil];
    NSString* content = [NSString stringWithContentsOfFile:fp
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    // Break down string and store it into the array
    NSArray *data = [content componentsSeparatedByString: @"\n"];
    NSString *info = @"N/A";
    for (int i = 0; i < [data count]; i++) {
        NSString *str = [data objectAtIndex:i];
        NSArray *ary = [str componentsSeparatedByString: @"::"];
        if ([state isEqualToString:[ary objectAtIndex:0]]) {
            info = [NSString stringWithFormat:@"Located in the Great State of %@\n\t%@", state, [ary objectAtIndex:2]];
        }
    }
    
    [self.labelField setText: info];
    [self.labelField sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
