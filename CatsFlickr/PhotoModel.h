//
//  PhotoModel.h
//  CatsFlickr
//
//  Created by Victor Hong on 21/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface PhotoModel : NSObject

@property NSString *farmID;
@property NSString *serverID;
@property NSString *photoID;
@property NSString *secretID;
@property NSString *titleDescription;
@property NSString *imageURL;
@property UIImage *imageFile;

-(instancetype)initWithFarmID:(NSString *)farmID andServerID:(NSString *)serverID andPhotoID:(NSString *)photoID andSecretID:(NSString *)secretID andTitleDescription:(NSString *)titleDescription;

-(void)convertImageURL;

@end
