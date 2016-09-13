//
//  ImageViewPickerUtils.h
//  MicroDriver
//
//  Created by Chen on 14-9-19.
//  Copyright (c) 2014年 Easepal. All rights reserved.
//

typedef enum : NSUInteger {
    ImageTypeCarma,
    ImageTypePhotoLibrary,
//    ,
} ImagePickerType;


/**
 *  选择图片工具类
 */
#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>


@protocol ImageViewPickerDelegate;

@interface ImageViewPickerUtils : NSObject<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

//@property (strong) UIImage *selectedImage;
/**
 *  回调选择的image
 */
@property (weak) id<ImageViewPickerDelegate> delegate;

@property (assign) NSUInteger tag;

/**
 *  执行选择图片
 */
-(void) pickImage;

@end


@protocol ImageViewPickerDelegate <NSObject>

/**
 *  回调
 *
 *  @param picker self
 *  @param image  所选择的图片
 */
-(void ) imageViewPickerUtils:(ImageViewPickerUtils*) picker didSelectedImage:(UIImage*) image;


/**
 *  获取图片Picker 类别
 *
 *  @param type ImagePickerType
 *
 *  @return PickController
 */
-(UIImagePickerController *) getImagePickerWithType:(ImagePickerType) type;




@end