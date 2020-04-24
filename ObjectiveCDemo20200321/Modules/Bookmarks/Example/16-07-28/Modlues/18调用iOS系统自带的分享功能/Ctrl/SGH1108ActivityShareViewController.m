//
//  SGH1108ActivityShareViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/8.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1108ActivityShareViewController.h"
#import "SGH1108ShareItem.h"
#import <Social/Social.h>


@interface SGH1108ActivityShareViewController ()

@end

@implementation SGH1108ActivityShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(0, 0, 100, 100);
    Button.center = self.view.center;
    Button.backgroundColor = [UIColor blueColor];
    [Button setTitle:@"分享到微信" forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(shareWX) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Button];
}


/** 分享到微信 以九宫格的方式*/
-(void)shareWX{
    /** 图片网址数组*/
    NSArray *array_photo = @[
                             @"http://img.meifajia.com/o1aneipt09eCl5bqQp4ifbQdTHlKIJfq.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneipt2fbZm38Zct4DH92p-ez7-fXt.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneiocd24Y6jK8uQA8-8y-47H6vRe7.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneiocdd94h6ld4kQJh8PcpjGSkORS.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneiocdd94h6ld4kQJh8PcpjGSkORS.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneipt09eCl5bqQp4ifbQdTHlKIJfq.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneioccpacV1LVg2AfG9fbYl8zN1So.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneipt0haf1zwepSkxx9okI0W34t05.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneipt09eCl5bqQp4ifbQdTHlKIJfq.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneipt09eCl5bqQp4ifbQdTHlKIJfq.jpg?imageView2/1/w/360/h/480/q/85",
                             @"http://img.meifajia.com/o1aneipt09eCl5bqQp4ifbQdTHlKIJfq.jpg?imageView2/1/w/360/h/480/q/85"];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i <8 && i<array_photo.count; i++) {
        NSString *URL = array_photo[i];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        UIImage *imagerang = [UIImage imageWithData:data];
        
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/ShareWX%d.jpg",i]];
        [UIImagePNGRepresentation(imagerang) writeToFile:imagePath atomically:YES];
        
        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
        
        /** 这里做个解释 imagerang : UIimage 对象  shareobj:NSURL 对象 这个方法的实际作用就是 在调起微信的分享的时候 传递给他 UIimage对象,在分享的时候 实际传递的是 NSURL对象 达到我们分享九宫格的目的 */
        
        SGH1108ShareItem *item = [[SGH1108ShareItem alloc] initWithData:imagerang andFile:shareobj];
        
        [array addObject:item];
    }
    
    
    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:nil];
    
    //尽量不显示其他分享的选项内容
    NSArray *activityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo];
  
//  @[
//                               UIActivityTypePostToFacebook,
//                               UIActivityTypePostToTwitter,
//                               UIActivityTypePostToWeibo,
//                               UIActivityTypeMessage,
//                               UIActivityTypeMail,
//                               UIActivityTypePrint,
//                               UIActivityTypeCopyToPasteboard,
//                               UIActivityTypeAssignToContact,
//                               UIActivityTypeSaveToCameraRoll,
//                               UIActivityTypeAddToReadingList,
//                               UIActivityTypePostToFlickr,
//                               UIActivityTypePostToVimeo,
//                               UIActivityTypePostToTencentWeibo,
//                               UIActivityTypeAirDrop,
//                               //UIActivityTypeOpenInIBooks
//                               ];
    activityViewController.excludedActivityTypes = activityTypes;
    //分享结果回调方法
    UIActivityViewControllerCompletionHandler myblock = ^(NSString *type,BOOL completed){
        NSLog(@"%d %@",completed,type);
    };
    activityViewController.completionHandler = myblock;
    
    if (activityViewController) {
        [self presentViewController:activityViewController animated:TRUE completion:nil];
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
