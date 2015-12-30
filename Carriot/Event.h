//
//  Event.h
//  Carriot
//
//  Created by user on 12/29/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSString * costo;
@property (nonatomic, retain) NSString * fecha;
@property (nonatomic, retain) NSString * hora;
@property (nonatomic, retain) NSString * idtipoevento;
@property (nonatomic, retain) NSString * urlimagen;
@property (nonatomic, retain) NSDate * fecha_aux;

@end
