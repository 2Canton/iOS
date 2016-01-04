//
//  CAEventsCategoryViewController.m
//  Carriot
//
//  Created by user on 1/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CAEventsCategoryViewController.h"
#import "CAOptionTableViewCell.h"
#import "CAEventCategory.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CAEventsViewController.h"

@interface CAEventsCategoryViewController ()

@end

@implementation CAEventsCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setDataSource:self];
    
    [self.activityIndicator startAnimating];
    
    [self loadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) loadData
{
    self.collection = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    [client invokeAPI:@"events"
                 body:nil
           HTTPMethod:@"GET"
           parameters:nil
              headers:nil
           completion:  ^(NSDictionary *result,
                          NSHTTPURLResponse *response,
                          NSError *error){
               if(error) { // error is nil if no error occured
                   NSLog(@"ERROR %@", error);
               } else {
                   
                   for(NSDictionary *item in result)
                   {
                       
                       CAEventCategory *eventCategory = [[CAEventCategory alloc] init];
                       
                       for (NSString *key in item) {
                           if ([eventCategory respondsToSelector:NSSelectorFromString(key)]) {
                               [eventCategory setValue:[item valueForKey:key] forKey:key];
                           }
                       }
                       
                       
                       
                       [self.collection addObject:eventCategory];
                       
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
    static NSString * cellIdentifier = @"eventCategoryTableViewCell";
    
    CAOptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CAOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    CAEventCategory  *eventCategory = [self.collection objectAtIndex:row];
    
    [cell.lblTitle setText:eventCategory.nombre];
    
    [cell.lblSubtitle setText:[NSString stringWithFormat:@"Cantidad: %@",eventCategory.cantidad_eventos]];
    
    /*
     [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:eventCategory.urlimagen]
     placeholderImage:[UIImage imageNamed:@"picture.png"]];
     */
    [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:eventCategory.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         NSLog(@"%@",error.description);
         if (error != nil)
         {
             [cell.imgLogo setImage:[UIImage imageNamed:@"picture_removed.png"]];
         }
     }];
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"events"])
    {
        
        CAEventsViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        CAEventCategory  *eventCategory = [self.collection objectAtIndex:row];
        
        view.idCategory = eventCategory.id;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // mostramos el segue
    [self performSegueWithIdentifier:@"events" sender:self];
    
}
@end
