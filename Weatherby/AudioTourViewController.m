//
//  AudioTourViewController.m
//  Weatherby
//
//  Created by user2492 on 3/6/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "AudioTourViewController.h"
#import "AudioPlayerViewController.h"

@interface AudioTourViewController ()

// Made array for datas
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *tableName;

@end

@implementation AudioTourViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    // Populated array data
    self.tableData = [NSMutableArray array];
    self.tableName = [NSMutableArray array];
    
    NSArray *d = [[NSBundle mainBundle] pathsForResourcesOfType:@"wav" inDirectory:nil];
    
    for(NSString *s in d)
    {
        //ßNSLog(@"%@", s);
        NSArray *components = [s componentsSeparatedByString:@"/"];
        NSString *curr = [components objectAtIndex:[components count] - 1];
        components = [curr componentsSeparatedByString:@"."];
        NSString *name = [components objectAtIndex:0];
        [self.tableData addObject:name];
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
    //NSInteger *row = indexPath.row;
    [self performSegueWithIdentifier:@"audioplayer" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"audioplayer"]) {
        int indexPath = [self.tableView indexPathForSelectedRow].row;
        AudioPlayerViewController *destViewController = segue.destinationViewController;
        destViewController.audiofile = [self.tableData objectAtIndex:indexPath];
    }
}

@end