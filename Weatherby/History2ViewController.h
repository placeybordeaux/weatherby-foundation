//
//  History2ViewController.h
//  Weatherby
//
//  Created by user2492 on 4/17/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History2ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *labelField;
@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (nonatomic, strong) NSString *title_info;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@end
