//
//  RRNewsList.m
//  RSSReader
//
//  Created by Alexey on 16.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "RRNewsList.h"
#import "RRNewsCell.h"
#import "RRNews.h"
#import "RRDataService.h"
#import "AsyncImageView.h"

@interface RRNewsList ()

@end

@implementation RRNewsList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_dataSource release];
    [_tableView release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Data Source
- (void)loadDataSource {
    [[RRDataService sharedInstance] loadRSSFeedWithCallback:^(NSArray* result){
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:result];
        [_tableView reloadData];
    }];
}

#pragma mark -
#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"RRNewsCell";
    
    RRNewsCell *cell = (RRNewsCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"RRNewsCell" owner:self options:nil];
        if (cellNib.count > 0) {
            cell = [cellNib objectAtIndex:0];
        }
    }
    cell.titleLabel.text = nil;
    cell.pubDateLabel.text = nil;

    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.icon];
    
    NSDictionary *currentDictionary = [_dataSource objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [currentDictionary objectForKey:@"title"];
    cell.pubDateLabel.text = [currentDictionary objectForKey:@"pubDate"];
    cell.icon.imageURL = [NSURL URLWithString:[currentDictionary objectForKey:@"image"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *currentDictionary = [_dataSource objectAtIndex:indexPath.row];
    RRNews *news = [[RRNews alloc] initWithURL:[NSURL URLWithString:[currentDictionary objectForKey:@"link"]] nibName:@"RRNews" bundle:nil];
    [self.navigationController pushViewController:news animated:YES];
    [news release];
}

#pragma mark -
#pragma mark Actions
- (IBAction)buttonRefreshClick:(id)sender {
    [self loadDataSource];
}



@end
