//
//  SingleWinnerViewController.m
//  Weatherby
//
//  Created by user2492 on 3/25/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "SingleWinnerViewController.h"

@interface SingleWinnerViewController() {
    
}

@property (nonatomic, strong) NSMutableArray *bios;

@end

@implementation SingleWinnerViewController

@synthesize name;
@synthesize info;
@synthesize labelField;
@synthesize img;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@", name);
    self.title = name;
    
    // Read content from local file
    NSString *fp = [[NSBundle mainBundle] pathForResource:@"WinnerBios" ofType:@"txt" inDirectory:nil];
    NSString* content = [NSString stringWithContentsOfFile:fp
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    // Break down string and store it into the array
    self.bios = [NSMutableArray array];
    NSArray *data = [content componentsSeparatedByString: @"\n"];
    NSArray *winnerdate = [name componentsSeparatedByString: @"-"];
    for (int i = 0; i < [data count]; i+=2) {
        NSString *str = [data objectAtIndex:i];
        NSArray *ary = [str componentsSeparatedByString: @"::"];
        if ([[ary objectAtIndex:0] intValue] == [[winnerdate objectAtIndex:0] intValue]) {
            info = [ary objectAtIndex:1];
            // Get image
            NSString* imgPath = [[NSBundle mainBundle] pathForResource:[ary objectAtIndex:0] ofType:@"jpg" inDirectory:nil];
            if (imgPath == NULL) {
                NSString *combined = [NSString stringWithFormat:@"%@.jpg", [ary objectAtIndex:0]];
                NSArray *tmpPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *directory = [tmpPath objectAtIndex:0];
                imgPath = [directory stringByAppendingPathComponent:combined];
            }
            NSLog(@"%@", imgPath);
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imgPath];
            [img setImage: image];
            img.contentMode = UIViewContentModeScaleAspectFit;
            info = [NSString stringWithFormat:@"%@\n\n%@", [data objectAtIndex: i + 1], info];
        }
        [self.bios addObject:str];
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
