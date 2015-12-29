//
//  EventsCategoryTableViewController.m
//  Carriot
//
//  Created by user on 12/29/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "EventsCategoryTableViewController.h"
#import "OptionTableViewCell.h"
#import "EventCategory.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EventsCategoryTableViewController ()
{
    NSMutableArray *collection;
}
@end

@implementation EventsCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // se establece la imagen de fondo
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    UIImageView *tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iglesia.png"]];
    [tableBackgroundView setFrame: self.tableView.frame];
    
    [self.tableView setBackgroundView:tableBackgroundView];
    
    [self.activityIndicator startAnimating];
    
    [self loadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) loadData
{
    collection = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    MSTable *table = [client tableWithName:@"TipoEvento"];
    MSQuery *query = [table query];
    [query orderByAscending:@"nombre"];
    
    
    [query readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            NSLog(@"ERROR %@", error);
        } else {
            for(NSDictionary *item in result.items)
            {
                // items is NSArray of records that match query
                
                EventCategory *eventCategory = [[EventCategory alloc] init];
                
                for (NSString *key in item) {
                    if ([eventCategory respondsToSelector:NSSelectorFromString(key)]) {
                        [eventCategory setValue:[item valueForKey:key] forKey:key];
                    }
                }
                
                
                
                [collection addObject:eventCategory];
                
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
    static NSString * cellIdentifier = @"eventCategoryTableViewCell";
    
    OptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[OptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    EventCategory  *eventCategory = [collection objectAtIndex:row];
    
    [cell.lblTitle setText:eventCategory.nombre];
    
    [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:eventCategory.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}

/*
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"schedule"])
    {
        CompaniesTableViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        CompaniesCategory  *companiesCategory = [collection objectAtIndex:row];
        
        view.idCategory = companiesCategory.id;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // mostramos el segue
    //[self performSegueWithIdentifier:@"companies" sender:self];
    
}
 */
@end
