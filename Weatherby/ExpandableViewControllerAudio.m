//
//  ExpandableViewControllerAudio.m
//  Weatherby
//
//  Created by user2492 on 3/4/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "ExpandableViewControllerAudio.h"

static NSInteger numberOfRow = 6;
@implementation ExpandableViewControllerAudio

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
    tv.delegate = self;
    tv.dataSource = self;
    [self.view addSubview:tv];
    
    ar = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Identifier";
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
									  reuseIdentifier:identifier];
		cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [ar objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *currentCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([currentCell.textLabel.text isEqualToString:@"0" ])
    {
        if (cell0_ison == NO)
        {
            NSString *book = @"book0";
            [ar insertObject:book atIndex:indexPath.row+1];
            numberOfRow++;
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
        {
            [ar removeObjectAtIndex:indexPath.row+1];
            numberOfRow--;
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        cell0_ison = !cell0_ison;
    }
    if ([currentCell.textLabel.text isEqualToString:@"1" ])
    {
        if (cell1_ison == NO)
        {
            NSString *book = @"book1";
            [ar insertObject:book atIndex:indexPath.row+1];
            numberOfRow++;
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
        {
            [ar removeObjectAtIndex:indexPath.row+1];
            numberOfRow--;
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        cell1_ison = !cell1_ison;
    }
    if ([currentCell.textLabel.text isEqualToString:@"2" ])
    {
        if (cell2_ison == NO)
        {
            NSString *book = @"book2";
            [ar insertObject:book atIndex:indexPath.row+1];
            numberOfRow++;
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
        {
            [ar removeObjectAtIndex:indexPath.row+1];
            numberOfRow--;
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        cell2_ison = !cell2_ison;
    }
    if ([currentCell.textLabel.text isEqualToString:@"3" ])
    {
        if (cell3_ison == NO)
        {
            NSString *book = @"book3";
            [ar insertObject:book atIndex:indexPath.row+1];
            numberOfRow++;
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
        {
            [ar removeObjectAtIndex:indexPath.row+1];
            numberOfRow--;
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        cell3_ison = !cell3_ison;
    }
    if ([currentCell.textLabel.text isEqualToString:@"4" ])
    {
        if (cell4_ison == NO)
        {
            NSString *book = @"book4";
            [ar insertObject:book atIndex:indexPath.row+1];
            numberOfRow++;
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
        {
            [ar removeObjectAtIndex:indexPath.row+1];
            numberOfRow--;
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        cell4_ison = !cell4_ison;
    }
    if ([currentCell.textLabel.text isEqualToString:@"5" ])
    {
        if (cell5_ison == NO)
        {
            NSString *book = @"book5";
            [ar insertObject:book atIndex:indexPath.row+1];
            numberOfRow++;
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
        else
        {
            [ar removeObjectAtIndex:indexPath.row+1];
            numberOfRow--;
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            
        }
        cell5_ison = !cell5_ison;
    }
    
    [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *currentCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([currentCell.textLabel.text isEqualToString:@"0" ]|| [currentCell.textLabel.text isEqualToString:@"1"] || [currentCell.textLabel.text isEqualToString:@"2"] || [currentCell.textLabel.text isEqualToString:@"3"] || [currentCell.textLabel.text isEqualToString:@"4"] || [currentCell.textLabel.text isEqualToString:@"5"])
    {
        return 40.0f;
    }
    else
    {
        return 80.0f;
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
