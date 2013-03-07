//
//  AudioTourViewController.m
//  Weatherby
//
//  Created by user2492 on 3/6/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "AudioTourViewController.h"
@interface AudioTourViewController ()

// Made array for datas
@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation AudioTourViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[DBAccountManager sharedManager] linkFromController:@"kDBRootDropbox"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"Winners.txt"];
    
    // Download and write to file
    NSURL *url = [NSURL URLWithString:@"https://dl.dropbox.com/s/itoeklwyqnvtk6y/Winners.txt?dl=1"];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [urlData writeToFile:filePath atomically:YES];
    NSString* content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    // Do any additional setup after loading the view, typically from a nib.
    // Populated array data
    self.tableData = [NSMutableArray array];
    NSArray *data = [content componentsSeparatedByString: @"\n"];
    for (int i = 0; i < [data count]; i++) {
        NSString *str = [data objectAtIndex:i];
        [self.tableData addObject:str];
    }
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"001.wav"
                                                     ofType:nil];
    NSLog(@"%@", path);
    NSArray *d = [[NSBundle mainBundle] pathsForResourcesOfType:@"wav" inDirectory:nil];
    for(NSString *s in d)
    {
        //NSLog(@"%@", s);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.tableData[indexPath.row];
    
    
    return cell;
}

// Cell Action Here
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get row selected here
    NSString *row = [[NSString alloc] initWithFormat:@"Aler, %ld", (long)indexPath.row];
    [self performSegueWithIdentifier:@"audioplayer" sender:self];
    // View row selected with alert
    //    UIAlertView *alert =
    //    [[UIAlertView alloc] initWithTitle: @"Title"
    //                               message: row
    //                              delegate: self
    //                     cancelButtonTitle: @"OK"
    //                     otherButtonTitles: nil];
    //    [alert show];
    
}

@end