//
//  Example2Controller.m
//  QRCode二维码
//
//  Created by huangaengoln on 15/11/9.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "Example2Controller.h"

@interface Example2Controller ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)UIButton *btnRead;

@end

@implementation Example2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btnRead=[UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:self.btnRead];
    self.btnRead.center=CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    [self.btnRead addTarget:self action:@selector(actionRead) forControlEvents:UIControlEventTouchUpInside];
}
-(void)actionRead {
    UIImagePickerController *photoPicker=[UIImagePickerController new];
    photoPicker.delegate=self;
    photoPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    photoPicker.view.backgroundColor=[UIColor whiteColor];
    [self presentViewController:photoPicker animated:YES completion:NULL];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *srcImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    CIContext *context=[CIContext contextWithOptions:nil];
    CIDetector *detector=[CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    CIImage *image=[CIImage imageWithCGImage:srcImage.CGImage];
    NSArray *features=[detector featuresInImage:image];
    CIQRCodeFeature *feature=[features firstObject];
    
    NSString *result=feature.messageString;
    if (result) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:result message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
