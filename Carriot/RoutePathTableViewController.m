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
#import "AppDelegate.h"

@interface RoutePathTableViewController ()
{
    NSMutableArray * collection;
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
    
    [self.activityIndicator startAnimating];
    
    // cargamos los datos en un array
    [self loadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData
{
    collection = [[NSMutableArray alloc]init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    NSDictionary *parameters = @{ @"idRuta": _idRoute, @"idHorario" : _idSchedule };
    
    [client invokeAPI:@"scheduledescription"
                 body:nil
           HTTPMethod:@"GET"
           parameters:parameters
              headers:nil
           completion:  ^(NSDictionary *result,
                          NSHTTPURLResponse *response,
                          NSError *error){
               if(error) { // error is nil if no error occured
                   NSLog(@"ERROR %@", error);
               } else {
                   
                   for(NSDictionary *item in result)
                   {
                       
                       RoutePath *routePath = [[RoutePath alloc] init];
                       
                       for (NSString *key in item) {
                           if ([routePath respondsToSelector:NSSelectorFromString(key)]) {
                               [routePath setValue:[item valueForKey:key] forKey:key];
                           }
                       }
                       
                       
                       
                       [collection addObject:routePath];
                       
                   }
                   
                   [self.tableView reloadData];
                   
                   
               }
               
               [self.activityIndicator stopAnimating];
               
               
           }];
    
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return collection.count;
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
    
    RoutePath *option = [collection objectAtIndex:row];
    
    [cell.lblPlace setText:option.nombresitiosalida];
    [cell.lblHour setText:option.hora];
    [cell.lblNote setText:option.nota];
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}



@end
