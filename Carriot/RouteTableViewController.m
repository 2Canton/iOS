//
//  RouteTableViewController.m
//  Carriot
//
//  Created by user on 12/27/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "RouteTableViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "Route.h"
#import "OptionTableViewCell.h"
#import "Option.h"
#import "AppDelegate.h"

@interface RouteTableViewController ()
{
    NSMutableArray *routesCollection;
    NSArray *routeImages;
    NSString * imageName;
}
@end

@implementation RouteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    
    // se establece la imagen de fondo
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    UIImageView *tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iglesia.png"]];
    [tableBackgroundView setFrame: self.tableView.frame];
    
    [self.tableView setBackgroundView:tableBackgroundView];
    
    // se llena el array de imágenes
    routeImages = @[@"bus0.png",@"bus1.png"];
    
    [self loadRoutes];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadRoutes
{
    routesCollection = [[NSMutableArray alloc] init];
        
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    MSTable *table = [client tableWithName:@"ruta"];
    MSQuery *query = [table query];
    [query orderByAscending:@"nombre"];
    
    
    [query readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            NSLog(@"ERROR %@", error);
        } else {
            for(NSDictionary *item in result.items)
            {
                // items is NSArray of records that match query
                //NSLog(@"Name: %@", [item objectForKey:@"nombre"]);
                
                Route *route = [[Route alloc] init];
                
                for (NSString *key in item) {
                    if ([route respondsToSelector:NSSelectorFromString(key)]) {
                        [route setValue:[item valueForKey:key] forKey:key];
                    }
                }
                
                
                
                [routesCollection addObject:route];
                
            }
            
            
            [self.tableView reloadData];
            
        }
        
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return routesCollection.count;
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
    static NSString * cellIdentifier = @"routeTableViewCell";
    
    OptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    long row = [indexPath section];
    
    Route  *route = [routesCollection objectAtIndex:row];
    
    
    [cell.lblTitle setText:route.nombre];
    
    imageName = [NSString stringWithFormat:@"bus%@.png",route.idempresa];
    
    
    //[cell.imgLogo setImage:[UIImage imageNamed:[routeImages objectAtIndex:[option.idempresa integerValue]]]];
    [cell.imgLogo setImage:[UIImage imageNamed:imageName]];
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}@end
