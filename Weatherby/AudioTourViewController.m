//
//  AudioTourViewController.m
//  Weatherby
//
//  Created by user2492 on 3/6/13.
//  Copyright (c) 2013 Weatherby Foundation. All rights reserved.
//

#import "AudioTourViewController.h"
#import "AudioPlayerViewController.h"

@interface AudioTourViewController (){
    NSArray *unfilteredWavs;
}

// Made array for datas
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *tableName;

@end

@implementation AudioTourViewController

@synthesize localTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.localSearchBar.delegate = self;
    self.localTableView.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    // Populated array data
    self.tableData = [NSMutableArray array];
    self.tableName = [NSMutableArray array];
    
    NSArray *d = [[NSBundle mainBundle] pathsForResourcesOfType:@"wav" inDirectory:nil];
    
    for(NSString *s in d)
    {
        //ßNSLog(@"%@", s);
        NSArray *components = [s componentsSeparatedByString:@"/"];
        NSString *curr = [components objectAtIndex:[components count] - 1];
        components = [curr componentsSeparatedByString:@"."];
        NSString *name = [components objectAtIndex:0];
        [self.tableData addObject:name];
    }
    //for the searching bar
    unfilteredWavs = self.tableData.copy;
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
        [self fillTable:unfilteredWavs];
    } else {
        NSMutableArray *filteredWavs = [[NSMutableArray alloc]init];
        for (NSString *str in unfilteredWavs) {
            NSRange r = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound){
                [filteredWavs addObject:str];
            }
        }
        [self fillTable:filteredWavs];
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
    NSInteger *row = indexPath.row;
    [self performSegueWithIdentifier:@"audioplayer" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"audioplayer"]) {
        int indexPath = [self.localTableView indexPathForSelectedRow].row;
        AudioPlayerViewController *destViewController = segue.destinationViewController;
        destViewController.audiofile = [self.tableData objectAtIndex:indexPath];
    }
}

@end