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
    Boolean win = false;
    NSArray *dateDownloaded;
    NSArray *dateNow;
    
    // Get paths
    NSString *fp = [[NSBundle mainBundle] pathForResource:@"WinnerBios" ofType:@"txt" inDirectory:nil];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Winners" ofType:@"txt" inDirectory:nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UpdateWin" ofType:@"txt" inDirectory:nil];
    NSString *localContent = [NSString stringWithContentsOfFile:path
                                                       encoding:NSUTF8StringEncoding
                                                          error:NULL];
    
    // Get update timestamp from DROPBOX
    NSURL *updateURL = [NSURL URLWithString:@"https://www.dropbox.com/s/k24fhvk6zqar09q/UpdateWin.txt?dl=1"];
    NSData *updateData = [NSData dataWithContentsOfURL:updateURL];
    [updateData writeToFile:path atomically:YES];
    NSString* downloadedContent = [NSString stringWithContentsOfFile:path
                                                            encoding:NSUTF8StringEncoding
                                                               error:NULL];
    //NSLog(@"%@\n", localContent);
    //NSLog(@"%@\n", downloadedContent);
    // Grab date
    dateDownloaded = [downloadedContent  componentsSeparatedByString: @"-"];
    dateNow = [localContent componentsSeparatedByString:@"-"];
    
    // Compate by year, month, day
    if ([[dateDownloaded objectAtIndex:0] intValue] > [[dateNow objectAtIndex:0] intValue]) {
        // True
        win = true;
    } else if ([[dateDownloaded objectAtIndex:0] intValue] == [[dateNow objectAtIndex:0] intValue] && [[dateDownloaded objectAtIndex:1] intValue] > [[dateNow objectAtIndex:1] intValue]) {
        // True
        win = true;
    } else if ([[dateDownloaded objectAtIndex:0] intValue] == [[dateNow objectAtIndex:0] intValue] && [[dateDownloaded objectAtIndex:1] intValue] == [[dateNow objectAtIndex:1] intValue] && [[dateDownloaded objectAtIndex:2] intValue] > [[dateNow objectAtIndex:2] intValue]) {
        // True
        win = true;
    }
    
    if (win) {
        //Download and write files
        NSURL *u = [NSURL URLWithString:@"https://www.dropbox.com/s/toe1i21p5ix3263/WinnerBios.txt?dl=1"];
        NSData *ud = [NSData dataWithContentsOfURL:u];
        [ud writeToFile:fp atomically:YES];
        
        // Download and write to file
        NSURL *url = [NSURL URLWithString:@"https://www.dropbox.com/s/06elvk2oec42quy/Winners.txt?dl=1"];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        [urlData writeToFile:filePath atomically:YES];
        
        // Download new pictures file 
        NSURL *picUrl = [NSURL URLWithString:@"https://www.dropbox.com/s/edvkeucaxcjz5lx/Pictures.txt?dl=1"];
        NSData *picData = [NSData dataWithContentsOfURL:picUrl];
        NSString *picPath = [[NSBundle mainBundle] pathForResource:@"Pictures" ofType:@"txt" inDirectory:nil];
        [picData writeToFile:picPath atomically:YES];
        NSString* picContent = [NSString stringWithContentsOfFile:picPath
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        
       
        NSArray *broken = [picContent componentsSeparatedByString:@"\n"];
        
        for (int j = 0; j < [broken count]; j++) {
            
            NSArray *ary = [[broken objectAtIndex:j] componentsSeparatedByString:@"::"];
            //NSLog(@"%d", [ary count]);
            if ([ary count] > 1) {
            NSString *tempPath = [[NSBundle mainBundle] pathForResource:[ary objectAtIndex:1] ofType:@"jpg" inDirectory:nil];
            
            if (tempPath == NULL) {
                NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *combined = [NSString stringWithFormat:@"%@.jpg", [ary objectAtIndex:1]];
                tempPath = [NSString stringWithFormat:@"%@/%@", docDir, combined];
                combined = [NSString stringWithFormat:@"%@?dl=1", [ary objectAtIndex:0]];
                NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:combined]];
                                
                [data2 writeToFile:tempPath atomically:YES];
            }
            }
        }
    }
    
    
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