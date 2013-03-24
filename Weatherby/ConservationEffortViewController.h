//
//  ConservationEffortViewController.h
//  Weatherby
//
//  Created by user2492 on 3/19/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConservationEffortViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *localSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *localTableView;

- (void) fillTable:(NSArray*) arr;

@end