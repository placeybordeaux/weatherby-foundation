//
//  AudioTourViewController.h
//  Weatherby
//
//  Created by user2492 on 3/7/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioTourViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *localSearchBar;
@property (nonatomic, strong) IBOutlet UITableView *localTableView;

- (void) fillTable:(NSArray*) arr;

@end
