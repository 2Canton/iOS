//
//  CACompaniesCategoryViewController.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CACompaniesCategoryViewController.h"
#import "CAOptionTableViewCell.h"
#import "CACompaniesCategory.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "AppDelegate.h"
#import "CACompaniesViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CACompaniesCategoryViewController ()

@end

@implementation CACompaniesCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setDataSource:self];
    
    [self.activityIndicator startAnimating];
    
    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDataOffline
{
    self.collection = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        [self.collection addObject:[[CACompaniesCategory alloc] initWithId:@"1" Name:@"Nombre1" PictureURL:@"url" Description:@"desc"]];
    }
    
    
}

- (void) loadData
{
    self.collection = [[NSMutableArray alloc] init];
    
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
                
                CACompaniesCategory *companiesCategory = [[CACompaniesCategory alloc] init];
                
                for (NSString *key in item) {
                    if ([companiesCategory respondsToSelector:NSSelectorFromString(key)]) {
                        [companiesCategory setValue:[item valueForKey:key] forKey:key];
                    }
                }
                
                
                
                [self.collection addObject:companiesCategory];
                
            }
            
            
            [self.tableView reloadData];
            
            
            
        }
        [self.activityIndicator stopAnimating];
        
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.collection.count;
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
    
    CAOptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CAOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    CACompaniesCategory  *companyCategory = [self.collection objectAtIndex:row];
    
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
        CACompaniesViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        CACompaniesCategory  *companiesCategory = [self.collection objectAtIndex:row];
        
        view.idCategory = companiesCategory.id;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // mostramos el segue
    [self performSegueWithIdentifier:@"companies" sender:self];
    
}

@end
