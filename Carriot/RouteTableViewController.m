//
//  RouteTableViewController.m
//  Carriot
//
//  Created by user on 12/27/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "RouteTableViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "ruta.h"
#import "OptionTableViewCell.h"
#import "Option.h"

@interface RouteTableViewController ()
{
    NSMutableArray *routesCollection;
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
    
    [self loadData];
    
}

- (void) loadData
{
    routesCollection = [[NSMutableArray alloc]init];
    
    [routesCollection addObject:[[Option alloc] initWithTitle:@"Historia" PictureURL:@"history.png"]];
    [routesCollection addObject:[[Option alloc] initWithTitle:@"Rutas" PictureURL:@"routes.png"]];
    [routesCollection addObject:[[Option alloc] initWithTitle:@"Sitios de interés" PictureURL:@"building.png"]];
    [routesCollection addObject:[[Option alloc] initWithTitle:@"Eventos" PictureURL:@"event.png"]];
    [routesCollection addObject:[[Option alloc] initWithTitle:@"Religión" PictureURL:@"church.png"]];
    [routesCollection addObject:[[Option alloc] initWithTitle:@"Facebook" PictureURL:@"facebook.png"]];
    [routesCollection addObject:[[Option alloc] initWithTitle:@"Sitio Web" PictureURL:@"website.png"]];
    [routesCollection addObject:[[Option alloc] initWithTitle:@"Contacto" PictureURL:@"message.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getLatestLoans
{
    routesCollection = [[NSMutableArray alloc] init];
    
    MSClient *client = [MSClient
                        clientWithApplicationURLString:@"https://puriscal.azure-mobile.net/"
                        applicationKey:@"CtavDeXtaLeUclXFhrPrjLJiUeeEek84"];
    
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
                
                ruta *route = [[ruta alloc] init];
                
                for (NSString *key in item) {
                    if ([route respondsToSelector:NSSelectorFromString(key)]) {
                        [route setValue:[item valueForKey:key] forKey:key];
                    }
                }
                
                
                
                [routesCollection addObject:item];
                
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
    
    Option *option = [routesCollection objectAtIndex:row];
    
    [cell.lblTitle setText:option.title];
    [cell.imgLogo setImage:[UIImage imageNamed:option.image]];
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}@end
