//
//  AudioPlayerViewController.m
//  Weatherby
//
//  Created by user2492 on 3/5/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "AudioPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayerViewController () {
    AVAudioPlayer *avPlayer;
}

// Made array for datas
@property (nonatomic, strong) NSArray *tableData;
@property BOOL editing;

@end
@implementation AudioPlayerViewController

@synthesize audiofile;

- (IBAction)playSound:(id)sender {
}

- (IBAction)stopButton:(id)sender {
    [avPlayer stop];
    [avPlayer setCurrentTime:0];
}

- (IBAction)pauseButton:(id)sender {
    [avPlayer pause];
}

- (IBAction)playButton:(id)sender {
    [avPlayer play];
    
}

- (IBAction)changeSongPosition:(id)sender {
    UISlider *volumeSlider=sender;
    [avPlayer setCurrentTime:volumeSlider.value * avPlayer.duration];
}

- (IBAction)moveStart:(id)sender {
    _editing = true;
}

- (IBAction)moveEnd:(id)sender {
    UISlider *volumeSlider=sender;
    [avPlayer setCurrentTime:volumeSlider.value * avPlayer.duration];
    _editing = false;
    NSLog(@"asdf");
}

-(void)updateMyProgress{
    if (!_editing){
    float progress =[avPlayer currentTime]/[avPlayer duration];
    self.songProgressView.progress=progress;
    self.volumeSlider.value = progress;
    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    [avPlayer stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *strPath=[[NSBundle mainBundle]pathForResource:audiofile ofType:@"wav"];
    NSURL *url=[NSURL fileURLWithPath:strPath];
    NSError *error;
    avPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [avPlayer setNumberOfLoops:0];
    [avPlayer setVolume:0.5];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateMyProgress) userInfo:nil repeats:YES];
    _editing = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

