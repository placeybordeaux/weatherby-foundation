//
//  AudioPlayerViewController.h
//  Weatherby
//
//  Created by user2492 on 3/5/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioPlayerViewController : UIViewController

@property (nonatomic, strong) NSString *audiofile;

@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UIProgressView *songProgressView;
- (IBAction)stopButton:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)playButton:(id)sender;
- (IBAction)moveStart:(id)sender;
- (IBAction)moveEnd:(id)sender;

@end