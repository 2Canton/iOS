//
//  RoutePath.m
//  Carriot
//
//  Created by user on 12/27/15.
//  Copyright © 2015 user. All rights reserved.
//

#import "RoutePath.h"

@implementation RoutePath

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
