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
    
    //[[DBAccountManager sharedManager] linkFromController:@"kDBRootDropbox"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"WinnerBios.txt"];
    
    // Download and write to file
    NSURL *url = [NSURL URLWithString:@"https://www.dropbox.com/s/4xryuumf6xr3itq/WinnerBios.txt?dl=1"];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [urlData writeToFile:filePath atomically:YES];
    NSString* content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    // Break down string and store it into the array
    self.bios = [NSMutableArray array];
    NSArray *data = [content componentsSeparatedByString: @"\n"];
    NSArray *winnerdate = [name componentsSeparatedByString: @"-"];
    for (int i = 0; i < [data count]; i++) {
        NSString *str = [data objectAtIndex:i];
        NSArray *ary = [str componentsSeparatedByString: @":"];
        if ([[ary objectAtIndex:0] intValue] == [[winnerdate objectAtIndex:[winnerdate count] - 1] intValue]) {
            info = [ary objectAtIndex:1];
            // Get image
            NSString* imgPath = [[NSBundle mainBundle] pathForResource:[ary objectAtIndex:0] ofType:@"jpg" inDirectory:nil];
            NSLog(@"\n\nthe string %@",filePath);
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imgPath];
            
            [img setImage: image];
            NSLog(@"%f,%f",image.size.width,image.size.height);
        }
        [self.bios addObject:str];
    }
    
    [self.labelField setText: info];
    self.labelField.numberOfLines = 0;
    [self.labelField sizeToFit];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
