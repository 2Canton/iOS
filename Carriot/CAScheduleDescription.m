//
//  CAScheduleDescription.m
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import "CAScheduleDescription.h"

@implementation CAScheduleDescription

- (id) initWithPlace: (NSString *) pnombresitiosalida
                Hour: (NSString *) phora;

{
    
    if (self = [super init])
    {
        _nombresitiosalida = pnombresitiosalida;
        _hora = phora;
    }
    
    return self;
}

@end
