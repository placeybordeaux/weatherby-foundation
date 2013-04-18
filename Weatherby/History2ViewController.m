//
//  History2ViewController.m
//  Weatherby
//
//  Created by user2492 on 4/17/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "History2ViewController.h"


@implementation History2ViewController
@synthesize labelField;
@synthesize img;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Read content from local file
    NSString *fp = [[NSBundle mainBundle] pathForResource:@"history" ofType:@"txt" inDirectory:nil];
    NSString* content = [NSString stringWithContentsOfFile:fp
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    // Break down string and store it into the array
    if(fp)
    {
        NSArray *data = [content componentsSeparatedByString: @"\n"];
        NSString *info=@"";
        for (int i = 11; i < [data count]; i++) {
            info= [info stringByAppendingString: [data objectAtIndex:i]];
        }
        
        [self.labelField setText: info];
        [self.labelField sizeToFit];
        
    }
    
    NSString* imgPath = [[NSBundle mainBundle] pathForResource: @"Group_2" ofType:@"tif" inDirectory:nil];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imgPath];
    [img setImage: image];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
