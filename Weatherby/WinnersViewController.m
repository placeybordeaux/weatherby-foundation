//
//  WinnersViewController.m
//  Weatherby
//
//  Created by user2492 on 3/6/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "WinnersViewController.h"
#import "SingleWinnerViewController.h"

@interface WinnersViewController ()
{
    NSArray *unfilteredWinners;
}

// Made array for datas
@property (nonatomic, strong) NSMutableArray *tableData;

@end


@implementation WinnersViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.localSearchBar.delegate = self;
    self.localTableView.delegate = self;
    
    // Download and write to file
    NSString *fp = [[NSBundle mainBundle] pathForResource:@"WinnerBios" ofType:@"txt" inDirectory:nil];
    NSURL *u = [NSURL URLWithString:@"https://www.dropbox.com/s/4xryuumf6xr3itq/WinnerBios.txt?dl=1"];
    NSData *ud = [NSData dataWithContentsOfURL:u];
    [ud writeToFile:fp atomically:YES];    

    //[[DBAccountManager sharedManager] linkFromController:@"kDBRootDropbox"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Winners" ofType:@"txt" inDirectory:nil];
    
    // Download and write to file
    NSURL *url = [NSURL URLWithString:@"https://dl.dropbox.com/s/itoeklwyqnvtk6y/Winners.txt?dl=1"];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [urlData writeToFile:filePath atomically:YES];
    NSString* content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    // Break down string and store it into the array
    unfilteredWinners = [content componentsSeparatedByString: @"\n"];
    [self fillTable:unfilteredWinners];
}

- (void)fillTable:(NSArray *) arr {
    self.tableData = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i++) {
        NSString *str = [arr objectAtIndex:i];
        [self.tableData addObject:str];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        [self fillTable:unfilteredWinners];
    } else {
        NSMutableArray *filteredWinners = [[NSMutableArray alloc]init];
        for (NSString *str in unfilteredWinners) {
            NSRange r = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound){
                [filteredWinners addObject:str];
            }
        }
        [self fillTable:filteredWinners];
    }
    [self.localTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.localSearchBar resignFirstResponder];
}


//The next two methods are for hiding the keyboard when people try and scroll the table.
- (BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.localTableView setUserInteractionEnabled:NO];
    return TRUE;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.localSearchBar isFirstResponder] && [touch view] != self.localSearchBar)
    {
        [self.localSearchBar resignFirstResponder];
        [self.localTableView setUserInteractionEnabled:YES];
        
    }
    [super touchesBegan:touches withEvent:event];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.tableData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.tableData[indexPath.row];
    
    
    return cell;
}

// Cell Action Here
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get row selected here
    //NSString *row = [[NSString alloc] initWithFormat:@"Aler, %ld", (long)indexPath.row];
    [self performSegueWithIdentifier:@"winnerview" sender:self];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"winnerview"]) {
        int indexPath = [self.localTableView indexPathForSelectedRow].row;
        SingleWinnerViewController *destViewController = segue.destinationViewController;
        destViewController.name = [self.tableData objectAtIndex:indexPath];
    }
}

@end