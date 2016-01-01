//
//  EventDetailViewController.m
//  Carriot
//
//  Created by user on 12/31/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "EventDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EventDetailViewController ()
{
    NSDateFormatter *dateFormat;
}
@end

@implementation EventDetailViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
