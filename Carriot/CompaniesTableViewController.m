//
//  CompaniesTableViewController.m
//  Carriot
//
//  Created by user on 12/28/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "CompaniesTableViewController.h"
#import "CompanyTableViewCell.h"
#import "Company.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "AppDelegate.h"

@interface CompaniesTableViewController ()
{
    NSMutableArray *collection;
}
@end

@implementation CompaniesTableViewController

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
    
    MSTable *table = [client tableWithName:@"empresa"];
    MSQuery *query = [table query];
    [query orderByAscending:@"nombre"];
    
    
    [query readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            NSLog(@"ERROR %@", error);
        } else {
            for(NSDictionary *item in result.items)
            {
                // items is NSArray of records that match query
                
                Company *company = [[Company alloc] init];
                
                for (NSString *key in item) {
                    if ([company respondsToSelector:NSSelectorFromString(key)]) {
                        [company setValue:[item valueForKey:key] forKey:key];
                    }
                }
                
                
                
                [collection addObject:company];
                
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
    static NSString * cellIdentifier = @"companyTableViewCell";
    
    CompanyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    Company  *company = [collection objectAtIndex:row];
    
    [cell.lblName setText:company.nombre];
    
    // se carga la imagen
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData * imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:company.urlimagen]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (imgData)
            {
                UIImage *image = [UIImage imageWithData:imgData];
                
                if (image) {
                    [cell.imgLogo setImage:image];
                }
                else
                {
                    [cell.imgLogo setImage:[UIImage imageNamed:@"picture_removed.png"]];
                }
            }
            
        });
        
    });
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}





@end
