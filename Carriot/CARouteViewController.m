//
//  CARouteViewController.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CARouteViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "CARoute.h"
#import "CAOptionTableViewCell.h"
#import "AppDelegate.h"
#import "CAScheduleViewController.h"

@interface CARouteViewController ()
{
    NSString * imageName;
}
@end

@implementation CARouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collection = [[NSMutableArray alloc] init];
    
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
    
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    MSTable *table = [client tableWithName:@"ruta"];
    MSQuery *query = [table query];
    [query orderByAscending:@"nombre"];
    
    
    [query readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            NSLog(@"ERROR %@", error);
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:@"Error al conectar a internet, intente de nuevo"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        } else {
            for(NSDictionary *item in result.items)
            {
                // items is NSArray of records that match query
                //NSLog(@"Name: %@", [item objectForKey:@"nombre"]);
                
                CARoute *route = [[CARoute alloc] init];
                
                for (NSString *key in item) {
                    if ([route respondsToSelector:NSSelectorFromString(key)]) {
                        [route setValue:[item valueForKey:key] forKey:key];
                    }
                }
                
                
                
                [self.collection addObject:route];
                
            }
            
            
            [self.tableView reloadData];
            
            
            
        }
        [self.activityIndicator stopAnimating];
        
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.collection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
    
    CAOptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    long row = [indexPath section];
    
    CARoute  *route = [self.collection objectAtIndex:row];
    
    
    [cell.lblTitle setText:route.nombre];
    
    imageName = [NSString stringWithFormat:@"bus%@.png",route.idempresa];
    
    
    //[cell.imgLogo setImage:[UIImage imageNamed:[routeImages objectAtIndex:[option.idempresa integerValue]]]];
    [cell.imgLogo setImage:[UIImage imageNamed:imageName]];
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"schedule"])
    {
        CAScheduleViewController * view = [segue destinationViewController];
        
        NSIndexPath * myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath section];
        
        CARoute  *route = [self.collection  objectAtIndex:row];
        
        view.idRoute = route.id;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // mostramos el segue
    [self performSegueWithIdentifier:@"schedule" sender:self];
    
}


@end
