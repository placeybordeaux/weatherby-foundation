//
//  ViewController.m
//  Weatherby
//
//  Created by user2492 on 2/18/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Made array for datas
@property (nonatomic, strong) NSArray *tableData;

@end

@implementation ViewController

-(IBAction)play {
    // Play audio file here
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"001", CFSTR ("mp3"),NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Populated array data
    self.tableData = @[@"A",@"B",@"C",@"D",@"E"];
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
    // View row selected with alert
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle: @"Title"
                               message: row
                              delegate: self
                     cancelButtonTitle: @"OK"
                     otherButtonTitles: nil];
    [alert show];
    
}


@end
