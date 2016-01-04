//
//  CAEventDetailViewController.m
//  Carriot
//
//  Created by user on 1/4/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CAEventDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CAEventDetailViewController ()
{
    NSDateFormatter *dateFormat;
}
@end

@implementation CAEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    [self.lblName setText: _event.nombre];
    
    [self.imgBanner sd_setImageWithURL:[NSURL URLWithString:_event.urlimagen]
                      placeholderImage:[UIImage imageNamed:@"picture.png"]];
    
    [self.lblDate setText: [NSString stringWithFormat:@"Fecha: %@",[dateFormat stringFromDate:_event.fecha_aux]]];
    [self.lblHour setText: [NSString stringWithFormat:@"Hora: %@",_event.hora]];
    [self.lblAmount setText: _event.costo];
    [self.lblDescription setText: _event.descripcion];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
