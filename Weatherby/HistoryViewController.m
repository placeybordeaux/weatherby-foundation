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
@synthesize labelField2;
@synthesize sv;
@synthesize img;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [sv setContentSize:CGSizeMake(320, 1000)];
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
        NSString *info2=@"";
        for (int i = 0; i < 6; i++) {
            info= [info stringByAppendingString: [data objectAtIndex:i]];
        }
        
        for (int i = 6; i < [data count]; i++) {
            info2= [info2 stringByAppendingString: [data objectAtIndex:i]];
        }
        
        [self.labelField setText: info];
        [self.labelField sizeToFit];
        
        [self.labelField2 setText: info2];
        [self.labelField2 sizeToFit];
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
