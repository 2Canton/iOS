//
//  CACompaniesViewController.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CACompaniesViewController.h"
#import "CACompanyTableViewCell.h"
#import "CACompany.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CACompaniesViewController ()

@end

@implementation CACompaniesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // se establece la imagen de fondo
    
    [self.tableView setDataSource:self];
    
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
    self.collection = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        [self.collection addObject:[[CACompany alloc] initWithId:@"1"
                                                       Name:@"Suuuuuuuuuuuuuuuuuuuuuuuuuuuuuper nooooooooombreeeeeee lml "
                                                    Address:@"300 metros oeste del cementerio de Puriscal"
                                                   Schedule:@"Lunes a Viernes de 7:00am a 7:00pm"
                                                 PictureURL:@"url"]];
    }
    
    
}

- (void) loadData
{
    self.collection = [[NSMutableArray alloc] init];
    
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    
    NSDictionary *parameters = @{ @"idTipoEmpresa": _idCategory };
    
    [client invokeAPI:@"companies_category"
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
                       
                       CACompany *company = [[CACompany alloc] init];
                       
                       for (NSString *key in item) {
                           if ([company respondsToSelector:NSSelectorFromString(key)]) {
                               [company setValue:[item valueForKey:key] forKey:key];
                           }
                       }
                       
                       
                       [self.collection addObject:company];
                       
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
    static NSString * cellIdentifier = @"companyTableViewCell";
    
    CACompanyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[CACompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    long row = [indexPath section];
    
    CACompany  *company = [self.collection objectAtIndex:row];
    
    [cell.lblName setText:company.nombre];
    
    [cell.lblAddress setText:company.direccion];
    
    [cell.lblTime setText:company.horario];
    
    // Here we use the new provided sd_setImageWithURL: method to load the web image
    [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:company.urlimagen]
                    placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}


@end
