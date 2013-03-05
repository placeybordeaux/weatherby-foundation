//
//  ExpandableViewControllerAudio.h
//  Weatherby
//
//  Created by user2492 on 3/4/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpandableViewControllerAudio  : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    UITableView *tv;
    NSMutableArray *ar;
    BOOL cell0_ison;
    BOOL cell1_ison;
    BOOL cell2_ison;
    BOOL cell3_ison;
    BOOL cell4_ison;
    BOOL cell5_ison;
    
}
@end
