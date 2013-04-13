//
//  SingleWinnerViewController.h
//  Weatherby
//
//  Created by user2492 on 3/25/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleWinnerViewController : UIViewController

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *info;
@property (weak, nonatomic) IBOutlet UITextView *labelField;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@end
