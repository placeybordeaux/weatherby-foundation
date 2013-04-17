//
//  HistoryViewController.h
//  Weatherby
//
//  Created by ruan chao on 13-4-15.
//  Copyright (c) 2013年 Weatherby Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *labelField;
@property (weak, nonatomic) IBOutlet UITextView *labelField2;
@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (nonatomic, strong) NSString *title_info;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@end
