//
//  CAEventsViewController.m
//  Carriot
//
//  Created by user on 1/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CAEventsViewController.h"
#import "AppDelegate.h"
#import "CAEventTableViewCell.h"
#import "CAEvent.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CAEventDetailViewController.h"

@interface CAEventsViewController ()
{
    NSMutableArray *collection;
    NSDateFormatter *dateFormat;
}
@end

@implementation CAEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    
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
    collection = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    NSDictionary *parameters = @{ @"idTipoEvento": _idCategory };
    
    [client invokeAPI:@"eventscategory"
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
                       
                       CAEvent *event = [[CAEvent alloc] init];
                       
                       for (NSString *key in item) {
                           if ([event respondsToSelector:NSSelectorFromString(key)]) {
                               [event setValue:[item valueForKey:key] forKey:key];
                           }
                       }
                       
                       
                       [collection addObject:event];
                       
                   }
                   
                   [self.tableView reloadData];
                   
               }
               
               [self.activityIndicator stopAnimating];
               
               if (collection.count == 0) {
                   [self.errorView setHidden:NO];
               }
               else
               {
                   [self.errorView setHidden:YES];
               }
               
               
               
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
    static NSString * cellIdentifier = @"eventTableViewCell";
    
    CAEventTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CAEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    CAEvent  *event = [collection objectAtIndex:row];
    
    [cell.lblName setText:event.nombre];
    
    
    
    [cell.lblDate setText:[NSString stringWithFormat:@"Fecha: %@",[dateFormat stringFromDate:event.fecha_aux]]];
    [cell.lblHour setText:[NSString stringWithFormat:@"Hora: %@",event.hora]];
    [cell.lblAmount setText:[NSString stringWithFormat:@"Costo: %@",event.costo]];
    
    [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:event.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"eventDetail"])
    {
        CAEventDetailViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        CAEvent  *event = [collection objectAtIndex:row];
        
        view.event = event;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // mostramos el segue
    [self performSegueWithIdentifier:@"eventDetail" sender:self];
    
}

@end
