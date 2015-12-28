//
//  RoutePathTableViewController.m
//  Carriot
//
//  Created by user on 12/27/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "RoutePathTableViewController.h"
#import "RoutePath.h"
#import "HourDescriptionTableViewCell.h"

@interface RoutePathTableViewController ()
{
    NSMutableArray * optionsArray;
}
@end

@implementation RoutePathTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // se establece la imagen de fondo
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    UIImageView *tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iglesia.png"]];
    [tableBackgroundView setFrame: self.tableView.frame];
    
    [self.tableView setBackgroundView:tableBackgroundView];
    
    // cargamos los datos en un array
    [self loadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData
{
    optionsArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 20; i++) {
        [optionsArray addObject:[[RoutePath alloc] initWithPlace:@"Puriscal" Hour:@"10:00am"]];
    }
    
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return optionsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"routePathTableViewCell";
    
    HourDescriptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    long row = [indexPath section];
    
    RoutePath *option = [optionsArray objectAtIndex:row];
    
    [cell.lblPlace setText:option.nombresitiosalida];
    [cell.lblHour setText:option.hora];
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}



@end
