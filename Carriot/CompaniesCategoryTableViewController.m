//
//  CompaniesCategoryTableViewController.m
//  Carriot
//
//  Created by user on 12/28/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "CompaniesCategoryTableViewController.h"
#import "OptionTableViewCell.h"
#import "CompaniesCategory.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "AppDelegate.h"
#import "CompaniesTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CompaniesCategoryTableViewController ()
{
    NSMutableArray *collection;
}
@end

@implementation CompaniesCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // se establece la imagen de fondo
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    UIImageView *tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iglesia.png"]];
    [tableBackgroundView setFrame: self.tableView.frame];
    
    [self.tableView setBackgroundView:tableBackgroundView];
    
    [self.activityIndicator startAnimating];
    
    [self loadData];
    //[self loadDataOffline];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDataOffline
{
    collection = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
         [collection addObject:[[CompaniesCategory alloc] initWithId:@"1" Name:@"Nombre1" PictureURL:@"url" Description:@"desc"]];
    }
   

}

- (void) loadData
{
    collection = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    MSTable *table = [client tableWithName:@"TipoEmpresa"];
    MSQuery *query = [table query];
    [query orderByAscending:@"nombre"];
    
    
    [query readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            NSLog(@"ERROR %@", error);
        } else {
            for(NSDictionary *item in result.items)
            {
                // items is NSArray of records that match query
                
                CompaniesCategory *companiesCategory = [[CompaniesCategory alloc] init];
                
                for (NSString *key in item) {
                    if ([companiesCategory respondsToSelector:NSSelectorFromString(key)]) {
                        [companiesCategory setValue:[item valueForKey:key] forKey:key];
                    }
                }
                
                
                
                [collection addObject:companiesCategory];
                
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
    static NSString * cellIdentifier = @"companiesCategoryTableViewCell";
    
    OptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[OptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    CompaniesCategory  *companyCategory = [collection objectAtIndex:row];
    
    [cell.lblTitle setText:companyCategory.nombre];
    
    [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:companyCategory.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"companies"])
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
    [self performSegueWithIdentifier:@"companies" sender:self];
    
}
 


@end
