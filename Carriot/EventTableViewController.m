//
//  EventTableViewController.m
//  Carriot
//
//  Created by user on 12/29/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "EventTableViewController.h"
#import "EventTableViewCell.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Event.h"
#import "EventDetailViewController.h"

@interface EventTableViewController ()
{
    NSMutableArray *collection;
    NSDateFormatter *dateFormat;
}
@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // se establece la imagen de fondo
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    UIImageView *tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iglesia.png"]];
    [tableBackgroundView setFrame: self.tableView.frame];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
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
                       
                       Event *event = [[Event alloc] init];
                       
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
    
    EventTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    Event  *event = [collection objectAtIndex:row];
    
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
        EventDetailViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        Event  *event = [collection objectAtIndex:row];
        
        view.event = event;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // mostramos el segue
    [self performSegueWithIdentifier:@"eventDetail" sender:self];
    
}


@end
