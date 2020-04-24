//
//  SGHSesstionDownloadViewController.h
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/26.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/**
 * @author hsj, 16-04-26 22:04:00
 *
 * 本例子来自:http://blog.csdn.net/majiakun1/article/details/38133789
 */

//https://zmall.hazq.com:8001/servlet/json?funcNo=902201&hardsn=710459C8-30D2-4AFE-91EB-26AC8289A8C5&platform=IOS&uuid=912C75F6-ABB6-4941-B2AB-9DBAB4986CCE&phoneNum=
//抽奖链接
#import <UIKit/UIKit.h>

@interface SGHSesstionDownloadViewController : UIViewController

/* NSURLSessions */
@property (strong, nonatomic)           NSURLSession *currentSession;    // 当前会话
@property (strong, nonatomic, readonly) NSURLSession *backgroundSession; // 后台会话

/* 下载任务 */
@property (strong, nonatomic) NSURLSessionDownloadTask *cancellableTask; // 可取消的下载任务
@property (strong, nonatomic) NSURLSessionDownloadTask *resumableTask;   // 可恢复的下载任务
@property (strong, nonatomic) NSURLSessionDownloadTask *backgroundTask;  // 后台的下载任务

/** 用于可恢复的下载任务的数据 */
@property (strong, nonatomic) NSData *partialData;

/* 显示已经下载的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *downloadedImageView;
/* 下载进度 */
@property (weak, nonatomic) IBOutlet UILabel *currentProgress_label;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadingProgressView;

/* 工具栏上的按钮 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancellableDownload_barButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resumableDownload_barButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backgroundDownload_barButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelTask_barButtonItem;

- (IBAction)cancellableDownload:(id)sender; /// 创建可取消的下载任务
- (IBAction)resumableDownload:(id)sender;   /// 创建可恢复的下载任务
- (IBAction)backgroundDownload:(id)sender;  /// 创建后台下载任务
- (IBAction)cancelDownloadTask:(id)sender;  /// 取消所有下载任务







@end
