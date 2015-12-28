//
//  ScheduleTableViewController.m
//  Carriot
//
//  Created by user on 12/27/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "Schedule.h"
#import "OptionTableViewCell.h"
#import "AppDelegate.h"

@interface ScheduleTableViewController ()
{
    NSMutableArray *shedulesCollection;
    NSString * imageName;
}
@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",_idRoute);
    
    
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
    shedulesCollection = [[NSMutableArray alloc] init];
    
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
                       
                       Schedule *schedule = [[Schedule alloc] init];
                       
                       for (NSString *key in item) {
                           if ([schedule respondsToSelector:NSSelectorFromString(key)]) {
                               [schedule setValue:[item valueForKey:key] forKey:key];
                           }
                       }
                       
                       
                       
                       [shedulesCollection addObject:schedule];
                       
                   }
                   
                   [self.tableView reloadData];
                
                   
               }
               
               [self.activityIndicator stopAnimating];
               
               
           }];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return shedulesCollection.count;
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
    
    OptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    long row = [indexPath section];
    
    Schedule  *schedule = [shedulesCollection objectAtIndex:row];
    
    
    [cell.lblTitle setText:schedule.dias];
    
    //imageName = [NSString stringWithFormat:@"bus%@.png",route.idempresa];
    
    
    //[cell.imgLogo setImage:[UIImage imageNamed:[routeImages objectAtIndex:[option.idempresa integerValue]]]];
    [cell.imgLogo setImage:[UIImage imageNamed:imageName]];
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}



@end
