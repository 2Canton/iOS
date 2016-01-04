//
//  CAEvent.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAEvent : NSObject

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
