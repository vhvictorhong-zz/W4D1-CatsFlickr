//
//  ViewController.m
//  CatsFlickr
//
//  Created by Victor Hong on 21/11/2016.
//  Copyright © 2016 Victor Hong. All rights reserved.
//

#import "ViewController.h"
#import "PhotoModel.h"
#import "CustomCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSMutableArray <PhotoModel *>*photoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.photoArray = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    CGFloat width = self.view.bounds.size.width/2;
    CGSize size = CGSizeMake(width, width);
    layout.itemSize = size;
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=7f402bc8f5775181bea39c7fc69187fd&tags=cat"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            //Handler the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSMutableDictionary *photoSearch = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            
            //Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary *photosDictionary = photoSearch[@"photos"];
        
        //If we reach this point, we have successfully retrieved the JSON from the API
        for (NSDictionary *photo in photosDictionary[@"photo"]) {

            NSString *farmID = photo[@"farm"];
            NSString *serverID = photo[@"server"];
            NSString *photoID = photo[@"id"];
            NSString *secretID = photo[@"secret"];
            NSString *titleDescription = photo[@"title"];
            
            [self.photoArray addObject:[[PhotoModel alloc] initWithFarmID:farmID andServerID:serverID andPhotoID:photoID andSecretID:secretID andTitleDescription:titleDescription]];
            
            NSLog(@"farm Id: %@", farmID);
            NSLog(@"server Id: %@", serverID);
            NSLog(@"photo Id: %@", photoID);
            NSLog(@"secret Id: %@", secretID);
            NSLog(@"secret Id: %@", titleDescription);
        
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            [self.collectionView reloadData];
            
        }];
        
        
    }];
    
    [dataTask resume];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photoArray.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    PhotoModel *photoModel = self.photoArray[indexPath.row];
    
    //Configure cell
    cell.imageView.image = photoModel.imageFile;
    cell.titleDescription.text = photoModel.titleDescription;
    
    return cell;
    
}

@end
