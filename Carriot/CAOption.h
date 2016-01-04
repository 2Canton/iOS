//
//  CAOption.h
//  Carriot
//
//  Created by user on 1/3/16.
//  Copyright © 2016 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAOption : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image;


- (id) initWithTitle: (NSString *) title
          PictureURL: (NSString *) pictureURL;

@end
