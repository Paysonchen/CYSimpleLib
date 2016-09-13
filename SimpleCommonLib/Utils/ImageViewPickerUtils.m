//
//  ImageViewPickerUtils.m
//  MicroDriver
//
//  Created by Chen on 14-9-19.
//  Copyright (c) 2014年 Easepal. All rights reserved.
//

#import "ImageViewPickerUtils.h"
//#import <MobileCoreServices/MobileCoreServices.h>

@implementation ImageViewPickerUtils


- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

-(void) pickImageFromPhoto
{
    [self pickImageWithType:ImageTypePhotoLibrary];

}

-(void) pickImage
{
    
//    if (![_delegate isKindOfClass:[UIViewController class]]) {
//        //
//        return;
//    }
    
    UIViewController *ctrl = [[[UIApplication sharedApplication].delegate window] rootViewController].presentedViewController? [[[UIApplication sharedApplication].delegate window] rootViewController].presentedViewController: [[[UIApplication sharedApplication].delegate window] rootViewController];
    //(UIViewController *)_delegate;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择选取图片方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [sheet showInView:ctrl.view];
    
    
    //    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
}
-(UIImagePickerController *) getImagePickerWithType:(ImagePickerType) type
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    switch (type) {
        case 0:
            //拍照
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                NSLog(@"sorry, no camera or camera is unavailable.");
                return nil;
            }
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
            break;
        case 1:
            //相册
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
            break;
//        case 2:
//        {
//            return nil;
//        }
            
        default:
            break;
    }
    
    NSArray * arr =  [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePicker.mediaTypes = arr;

    return imagePicker;
}
-(void) pickImageWithType:(ImagePickerType) type
{
    UIImagePickerController *imagePicker = [self getImagePickerWithType:type];
    if (!imagePicker) {
        return;
    }
    
    NSLog(@"self.presentedViewController =%@",[[[[UIApplication sharedApplication].delegate window] rootViewController] presentedViewController] );
    
    NSLog(@"[[[UIApplication sharedApplication].delegate window] rootViewController] = %@",[[[UIApplication sharedApplication].delegate window] rootViewController]);
    
    UIViewController *rootViewController = [[[UIApplication sharedApplication].delegate window] rootViewController];
    if (rootViewController.presentedViewController) {
        //
        [rootViewController.presentedViewController presentViewController:imagePicker animated:YES completion:nil];
    }else
    {
        [rootViewController presentViewController:imagePicker animated:YES completion:nil];

    }
    
//    [[[UIApplication sharedApplication].delegate window] rootViewController];
//    [ [[[UIApplication sharedApplication].delegate window] rootViewController] presentViewController:imagePicker animated:YES completion:nil];
    

}


#pragma  mark- UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        NSLog(@"取消");
        return;
    }
    NSLog(@"buttonIndex = %d",buttonIndex);
    
    [self pickImageWithType:buttonIndex];
}


#pragma  mark- UIImagePicker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //打印出字典中的内容
    NSLog(@"get the media info: %@", info);
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图像还是视频
    //判断是静态图像还是视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //获取用户编辑之后的图像
        UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //将该图像保存到媒体库中
//        self.selectedImage = editedImage;
        
        if (![_delegate respondsToSelector:@selector(imageViewPickerUtils:didSelectedImage:)]) {
            return;
        }
        [_delegate imageViewPickerUtils:self didSelectedImage:editedImage];
    }
    //    UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
