//
//  CAScheduleDescriptionViewController.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CAScheduleDescriptionViewController.h"
#import "CAScheduleDescription.h"
#import "CAScheduleDescriptionTableViewCell.h"
#import "AppDelegate.h"

@implementation CAScheduleDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // se establece la imagen de fondo

    [self.tableView setDataSource:self];
    
    [self.activityIndicator startAnimating];
    
    // cargamos los datos en un array
    [self loadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData
{
    self.collection = [[NSMutableArray alloc]init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    NSDictionary *parameters = @{ @"idRuta": _idRoute, @"idHorario" : _idSchedule };
    
    [client invokeAPI:@"scheduledescription"
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
                       
                       CAScheduleDescription *sheduleDescription = [[CAScheduleDescription alloc] init];
                       
                       for (NSString *key in item) {
                           if ([sheduleDescription respondsToSelector:NSSelectorFromString(key)]) {
                               [sheduleDescription setValue:[item valueForKey:key] forKey:key];
                           }
                       }
                       
                       
                       
                       [self.collection addObject:sheduleDescription];
                       
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
    static NSString * cellIdentifier = @"scheduleDescriptionTableViewCell";
    
    CAScheduleDescriptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    long row = [indexPath section];
    
    CAScheduleDescription *option = [self.collection objectAtIndex:row];
    
    // obtenemos las cifras que correspondes a la hora
    NSString * hourAux = [option.hora substringToIndex:2];
    
    NSString * minutes = [option.hora substringFromIndex:2];
    
    // convertimos el número a int
    int hourInt = [hourAux intValue];
    
    
    // se verifica si la hora es menor a 12
    if (hourInt < 12) {
        hourAux = [NSString stringWithFormat:@"%@%@",option.hora,
                   @" am"];
    }
    else if (hourInt == 12)
    {
        hourAux = [NSString stringWithFormat:@"%@%@",option.hora,
                   @" md"];
    }
    else{
        hourAux = [NSString stringWithFormat:@"%i%@%@",hourInt - 12,minutes,
                   @" pm"];
        
        
    }
    
    [cell.lblPlace setText:option.nombresitiosalida];
    [cell.lblHour setText:hourAux];
    [cell.lblNote setText:option.nota];
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}


@end
