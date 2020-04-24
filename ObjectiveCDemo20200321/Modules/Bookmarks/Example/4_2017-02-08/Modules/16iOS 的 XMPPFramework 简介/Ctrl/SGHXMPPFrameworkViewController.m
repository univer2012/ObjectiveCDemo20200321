//
//  SGHXMPPFrameworkViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/18.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGHXMPPFrameworkViewController.h"

//#import <XMPPFramework/XMPPFramework.h>

//@interface SGHXMPPFrameworkViewController ()<XMPPStreamDelegate>

//@property(nonatomic,strong)XMPPStream *xmppStream;

//@end

@implementation SGHXMPPFrameworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//-(void)connect {
//    if (self.xmppStream == nil) {
//        self.xmppStream = [[XMPPStream alloc]init];
//        [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    }
//    if (![self.xmppStream isConnected]) {
//        NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
//        XMPPJID *jid = [XMPPJID jidWithUser:username domain:@"lizhen" resource:@"Ework"];
//        [self.xmppStream setMyJID:jid];
//        [self.xmppStream setHostName:@"10.4.125.113"];
//        NSError *error = nil;
//        if (![self.xmppStream connectWithTimeout:3 error:&error]) {
//            NSLog(@"Connect Error: %@", [[error userInfo] description]);
//        }
//    }
//}

//MARK: XMPPStreamDelegate
//-(void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket {
//    
//}
//-(void)xmppStreamDidConnect:(XMPPStream *)sender {
//    
//}

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
