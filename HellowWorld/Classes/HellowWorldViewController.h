//
//  HellowWorldViewController.h
//  HellowWorld
//
//  Created by Lacey-bordeaux, Peter M on 2/15/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HellowWorldViewController : UIViewController {
	IBOutlet UILabel *Label;
	IBOutlet UIButton *Button;
}

@property (nonatomic,retain) IBOutlet UILabel *Label;
@property (nonatomic,retain) IBOutlet UIButton *Button;

-(IBAction) ClickMe_OnClick: (id) sender;

@end

