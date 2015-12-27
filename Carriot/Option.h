//
//  Option.h
//  Carriot
//
//  Created by user on 12/26/15.
//  Copyright © 2015 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Option : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image;


- (id) initWithTitle: (NSString *) title
          PictureURL: (NSString *) pictureURL;

@end
