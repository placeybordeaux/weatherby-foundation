//
//  AudioTourViewController.m
//  Weatherby
//
//  Created by user2492 on 3/6/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "AudioTourViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioTourViewController (){
    NSArray *unfilteredWavs;
    AVAudioPlayer *avPlayer;
}

// Made array for datas
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *tableName;
@property int currentIndex;

@end

@implementation AudioTourViewController

@synthesize localTableView;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //Once the view has loaded then we can register to begin recieving controls and we can become the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //End recieving events
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self resignFirstResponder];
}

//Make sure we can recieve remote control events
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
            [avPlayer play];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [avPlayer pause];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setDelegate: self];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError];
    [[AVAudioSession sharedInstance] setActive: YES error: &setCategoryError];
    
    [self.navigationController setToolbarHidden:NO animated:YES];

    
    self.localSearchBar.delegate = self;
    self.localTableView.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    // Populated array data
    self.tableData = [NSMutableArray array];
    self.tableName = [NSMutableArray array];
    
    NSArray *d = [[NSBundle mainBundle] pathsForResourcesOfType:@"wav" inDirectory:@"AudioTour"];
    
    for(NSString *s in d)
    {
        //ßNSLog(@"%@", s);
        NSArray *components = [s componentsSeparatedByString:@"/"];
        NSString *curr = [components objectAtIndex:[components count] - 1];
        components = [curr componentsSeparatedByString:@"."];
        NSString *name = [components objectAtIndex:0];
        [self.tableData addObject:name];
    }
    
    [self.tableData sortUsingComparator:^NSComparisonResult(id a, id b){
        
        NSString *aString = (NSString*) a;
        NSString *bString = (NSString*) b;
        return [[aString substringToIndex:2] intValue] > [[bString substringToIndex:2] intValue];
    }];
    
    
    //for the searching bar
    unfilteredWavs = self.tableData.copy;
}

- (void)fillTable:(NSArray *) arr {
    self.tableData = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i++) {
        NSString *str = [arr objectAtIndex:i];
        [self.tableData addObject:str];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        [self fillTable:unfilteredWavs];
    } else {
        NSMutableArray *filteredWavs = [[NSMutableArray alloc]init];
        for (NSString *str in unfilteredWavs) {
            NSRange r = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound){
                [filteredWavs addObject:str];
            }
        }
        [self fillTable:filteredWavs];
    }
    [self.localTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.localSearchBar resignFirstResponder];
}


//The next two methods are for hiding the keyboard when people try and scroll the table.
- (BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.localTableView setUserInteractionEnabled:NO];
    return TRUE;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.localSearchBar isFirstResponder] && [touch view] != self.localSearchBar)
    {
        [self.localSearchBar resignFirstResponder];
        [self.localTableView setUserInteractionEnabled:YES];
        
    }
    [super touchesBegan:touches withEvent:event];
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
    _currentIndex = indexPath.item;
    [self PlayIndex:_currentIndex];

}

-(void)PlayIndex:(int)index {
    if(index >= 0 && index < [self.tableData count]){
    NSString *audiofile = [self.tableData objectAtIndex:index];    
    NSString *strPath=[[NSBundle mainBundle]pathForResource:audiofile ofType:@"wav"
                                                inDirectory:@"AudioTour"];
    NSURL *url=[NSURL fileURLWithPath:strPath];
    NSError *error;
    avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];

    [avPlayer setNumberOfLoops:0];
    [avPlayer setVolume:0.5];
    [avPlayer play];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection: 0];

    
    [self.localTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else{
        [avPlayer stop];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
        
        
        [self.localTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        [self.localTableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }
    
}

- (IBAction)pauseButton:(id)sender {
    [avPlayer pause];
}

- (IBAction)playButton:(id)sender {
    [avPlayer play];
    
}

- (IBAction)prev:(id)sender {
    if (avPlayer.currentTime < 3){
        _currentIndex -= 1;
        [self PlayIndex:_currentIndex];
    }else {
        avPlayer.currentTime = 0;
    }
}


- (IBAction)next:(id)sender {
    _currentIndex += 1;
    [self PlayIndex:_currentIndex];
}

@end