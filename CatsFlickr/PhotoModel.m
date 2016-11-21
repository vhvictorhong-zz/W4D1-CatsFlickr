//
//  PhotoModel.m
//  CatsFlickr
//
//  Created by Victor Hong on 21/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

-(instancetype)initWithFarmID:(NSString *)farmID andServerID:(NSString *)serverID andPhotoID:(NSString *)photoID andSecretID:(NSString *)secretID andTitleDescription:(NSString *)titleDescription {
    
    if (self = [super init]) {
        
        _farmID = farmID;
        _serverID = serverID;
        _photoID = photoID;
        _secretID = secretID;
        _titleDescription = titleDescription;
        _imageURL = @"";
        
    }
    
    return self;
    
}

-(void)convertImageURL {
    
    self.imageURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", self.farmID, self.serverID, self.photoID, self.secretID];
    
    NSURL *url = [NSURL URLWithString:self.imageURL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *_Nullable location, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        
        if (error) {
            
            //Handle error
            NSLog(@"error: %@", error.localizedDescription);
            return;
            
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            
            
        }];
        
    }];
    
    [downloadTask resume];

}

@end
