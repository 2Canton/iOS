//
//  OptionTableViewController.m
//  Carriot
//
//  Created by user on 12/26/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "OptionTableViewController.h"
#import "Option.h"
#import "OptionTableViewCell.h"

@interface OptionTableViewController ()
{
    NSMutableArray * optionsArray;
}
@end

@implementation OptionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setContentInset:UIEdgeInsetsMake(20, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
    
    // se establece la imagen de fondo
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    UIImageView *tableBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iglesia.png"]];
    [tableBackgroundView setFrame: self.tableView.frame];
    
    [self.tableView setBackgroundView:tableBackgroundView];
    
    // cargamos los datos en un array
    [self loadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData
{
    optionsArray = [[NSMutableArray alloc]init];
    
    [optionsArray addObject:[[Option alloc] initWithTitle:@"Historia" PictureURL:@"history.png"]];
    [optionsArray addObject:[[Option alloc] initWithTitle:@"Rutas" PictureURL:@"routes.png"]];
    [optionsArray addObject:[[Option alloc] initWithTitle:@"Sitios de interés" PictureURL:@"building.png"]];
    [optionsArray addObject:[[Option alloc] initWithTitle:@"Eventos" PictureURL:@"event.png"]];
    [optionsArray addObject:[[Option alloc] initWithTitle:@"Religión" PictureURL:@"church.png"]];
    [optionsArray addObject:[[Option alloc] initWithTitle:@"Facebook" PictureURL:@"facebook.png"]];
    [optionsArray addObject:[[Option alloc] initWithTitle:@"Sitio Web" PictureURL:@"website.png"]];
    [optionsArray addObject:[[Option alloc] initWithTitle:@"Contacto" PictureURL:@"message.png"]];
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return optionsArray.count;
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
    static NSString * cellIdentifier = @"optionTableViewCell";
    
    OptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    long row = [indexPath section];
    
    Option *option = [optionsArray objectAtIndex:row];
    
    [cell.lblTitle setText:option.title];
    [cell.imgLogo setImage:[UIImage imageNamed:option.image]];
    
    
    [cell.layer setCornerRadius:35.0f];
    
    return cell;
}

@end
