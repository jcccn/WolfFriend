//
//  PictureNativeBrowserViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 9/14/13.
//  Copyright (c) 2013 SenseForce. All rights reserved.
//

#import "PictureNativeBrowserViewController.h"
#import <ALAssetsLibrary-CustomPhotoAlbum/ALAssetsLibrary+CustomPhotoAlbum.h>

@interface PictureNativeBrowserViewController () <MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) ALAssetsLibrary *assertsLibrary;

@end

@implementation PictureNativeBrowserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPictureUrls:(NSArray *)pictureUrls {
    self = [super initWithDelegate:self];
    if (self) {
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:[pictureUrls count]];
        for (NSString *pictureUrl in pictureUrls) {
            [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:pictureUrl]]];
        }
        self.photos = [NSArray arrayWithArray:photos];
        
        self.displayActionButton = YES;
        [self setCurrentPhotoIndex:0];
        
        self.assertsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override

- (void)actuallySavePhoto:(id<MWPhoto>)photo {
    if ([photo underlyingImage]) {
        __weak __typeof(&*self) weakSelf = self;
        [self.assertsLibrary saveImage:[photo underlyingImage]
                               toAlbum:@"春暖花开"
                            completion:^(NSURL *assetURL, NSError *error) {
                                if ([weakSelf respondsToSelector:@selector(image:didFinishSavingWithError:contextInfo:)]) {
                                    [weakSelf performSelector:@selector(image:didFinishSavingWithError:contextInfo:)
                                                   withObject:nil
                                                   withObject:error];
                                }
                            }
                               failure:^(NSError *error) {
                                   if ([weakSelf respondsToSelector:@selector(image:didFinishSavingWithError:contextInfo:)]) {
                                       [weakSelf performSelector:@selector(image:didFinishSavingWithError:contextInfo:)
                                                      withObject:nil
                                                      withObject:error];
                                   }
                               }];
    }
}

#pragma mark - MWPhotoBrowser Delegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return [self.photos count];
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < [self.photos count]) {
        return self.photos[index];
    }
    return nil;
}

@end
