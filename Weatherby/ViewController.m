//
//  ViewController.m
//  Weatherby
//
//  Created by user2492 on 2/18/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () {
        AVAudioPlayer *avPlayer;
}

// Made array for datas
@property (nonatomic, strong) NSArray *tableData;

@end
//Max

@implementation ViewController

-(IBAction)play {
    // Play audio file here
    // Do any additional setup after loading the view, typically from a nib.
//    NSString *strPath=[[NSBundle mainBundle]pathForResource:@"001" ofType:@"wav"];
//    NSURL *url=[NSURL fileURLWithPath:strPath];
//    
//    NSError *error;
//    avPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
//    [avPlayer setNumberOfLoops:1];
//    [avPlayer setVolume:self.volumeSlider.value];
//    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateMyPorgress) userInfo:nil repeats:YES];
    
//    CFBundleRef mainBundle = CFBundleGetMainBundle();
//    CFURLRef soundFileURLRef;
//    soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"001", CFSTR ("mp3"),NULL);
//    UInt32 soundID;
//    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
//    AudioServicesPlaySystemSound(soundID);
}

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
    NSLog(@"%@", content);
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
