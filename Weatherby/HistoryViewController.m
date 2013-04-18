//
//  HistoryViewController.m
//  Weatherby
//
//  Created by ruan chao on 13-4-15.
//  Copyright (c) 2013年 Weatherby Foundation. All rights reserved.
//

#import "HistoryViewController.h"


@implementation HistoryViewController
@synthesize title_info;
@synthesize labelField;
@synthesize sv;
@synthesize img;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = title_info;
    
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
        for (int i = 0; i < 11; i++) {
            info= [info stringByAppendingString: [data objectAtIndex:i]];
        }
        
        [self.labelField setText: info];
        [self.labelField sizeToFit];
        
    }
    
    NSString* imgPath = [[NSBundle mainBundle] pathForResource: @"Group_1" ofType:@"tif" inDirectory:nil];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imgPath];
    [img setImage: image];
    
}



- (void)didReceiveMemoryWarning
{
 [super didReceiveMemoryWarning];
}
@end
