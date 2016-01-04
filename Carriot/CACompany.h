//
//  CACompany.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACompany : NSObject

@property (nonatomic, retain) NSString * id;

@property (nonatomic, retain) NSString * nombre;

@property (nonatomic, retain) NSString * direccion;

@property (nonatomic, retain) NSDecimalNumber * longitud;

@property (nonatomic, retain) NSDecimalNumber * latitud;

@property (nonatomic, retain) NSString * telefonoprincipal;

@property (nonatomic, retain) NSString * telefonosecundario;

@property (nonatomic, retain) NSString * email;

@property (nonatomic, retain) NSString * web;

@property (nonatomic, retain) NSString * horario;

@property (nonatomic, retain) NSString * idtipodeempresa;

@property (nonatomic, retain) NSString * urlimagen;


- (id) initWithId: (NSString *) pId
             Name: (NSString *) pName
          Address: (NSString *) pAddress
         Schedule: (NSString *) pSchedule
       PictureURL: (NSString *) pPictureURL;

@end
