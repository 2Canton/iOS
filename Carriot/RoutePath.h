//
//  RoutePath.h
//  Carriot
//
//  Created by user on 12/27/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoutePath : NSObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *idruta;
@property (nonatomic, retain) NSString *nombresitiosalida;
@property (nonatomic, retain) NSString *idhorario;
@property (nonatomic, retain) NSString *nota;
@property (nonatomic, retain) NSString *hora;

- (id) initWithPlace: (NSString *) pnombresitiosalida
          Hour: (NSString *) phora;

@end
