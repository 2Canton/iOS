//
//  Company.h
//  Carriot
//
//  Created by user on 12/28/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

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
