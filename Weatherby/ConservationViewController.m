//
//  ConservationViewController.m
//  Weatherby
//
//  Created by user2492 on 3/18/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "ConservationViewController.h"
#import "SingleEffortViewController.h"


@interface ConservationViewController (){
    NSArray *unfilteredEfforts;
}

// Made array for datas
@property (nonatomic, strong) NSMutableArray *tableData;

@end


@implementation ConservationViewController

@synthesize localTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.localSearchBar.delegate = self;
    self.localTableView.delegate = self;
    
    //[[DBAccountManager sharedManager] linkFromController:@"kDBRootDropbox"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"ConservationEfforts.txt"];
    
    // Download and write to file
    NSURL *url = [NSURL URLWithString:@"https://www.dropbox.com/s/mevknt61g75osdw/ConservationEfforts.txt?dl=1"];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [urlData writeToFile:filePath atomically:YES];
    NSString* content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    // Break down string and store it into the array
    self.tableData = [NSMutableArray array];
    NSArray *data = [content componentsSeparatedByString: @"\n"];
    for (int i = 0; i < [data count]; i++) {
        NSString *str = [data objectAtIndex:i];
        [self.tableData addObject:str];
    }
    
    unfilteredEfforts = self.tableData.copy;
    
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
        [self fillTable:unfilteredEfforts];
    } else {
        NSMutableArray *filteredEfforts = [[NSMutableArray alloc]init];
        for (NSString *str in unfilteredEfforts) {
            NSRange r = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound){
                [filteredEfforts addObject:str];
            }
        }
        [self fillTable:filteredEfforts];
    }
    [self.localTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.localSearchBar resignFirstResponder];
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
    [self performSegueWithIdentifier:@"singleeffort" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"singleeffort"]) {
        int indexPath = [self.localTableView indexPathForSelectedRow].row;
        SingleEffortViewController *destViewController = segue.destinationViewController;
        destViewController.title_info = [self.tableData objectAtIndex:indexPath];
    }
}

@end
