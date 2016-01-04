//
//  CAScheduleViewController.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CAScheduleViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "CASchedule.h"
#import "CAOptionTableViewCell.h"
#import "AppDelegate.h"
#include <stdlib.h>
#import "CAScheduleDescriptionViewController.h"

@interface CAScheduleViewController ()

@end

@implementation CAScheduleViewController

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

- (void) loadData
{
    self.collection = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    NSDictionary *parameters = @{ @"id": _idRoute};
    
    [client invokeAPI:@"horarioruta"
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
                       
                       CASchedule *schedule = [[CASchedule alloc] init];
                       
                       for (NSString *key in item) {
                           if ([schedule respondsToSelector:NSSelectorFromString(key)]) {
                               [schedule setValue:[item valueForKey:key] forKey:key];
                           }
                       }
                       
                       
                       
                       [self.collection addObject:schedule];
                       
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
    static NSString * cellIdentifier = @"scheduleTableViewCell";
    
    CAOptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CAOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    long row = [indexPath section];
    
    CASchedule  *schedule = [self.collection objectAtIndex:row];
    
    [cell.lblTitle setText:schedule.dias];
    
    [cell.imgLogo setImage:[UIImage imageNamed:[self randomImage]]];
    
    [cell.layer setCornerRadius:35.0f];
        
    
    return cell;
}

- (NSString *) randomImage
{
    int number = arc4random_uniform(11);
    
    return [NSString stringWithFormat:@"calendar%i.png",number];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // mostramos el segue
    [self performSegueWithIdentifier:@"scheduleDescription" sender:self];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"scheduleDescription"])
    {
        CAScheduleDescriptionViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        CASchedule  *schedule = [self.collection objectAtIndex:row];
        
        view.idRoute = _idRoute;
        view.idSchedule = schedule.id;
    }
}



@end
