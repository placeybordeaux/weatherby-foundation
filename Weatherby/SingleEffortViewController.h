//
//  SingleEffortViewController.h
//  Weatherby
//
//  Created by user2492 on 3/25/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleEffortViewController : UIViewController

@property (nonatomic, strong) NSString *title_info;
@property (nonatomic, strong) NSString *state;
@property (weak, nonatomic) IBOutlet UITextView *labelField;

@end
