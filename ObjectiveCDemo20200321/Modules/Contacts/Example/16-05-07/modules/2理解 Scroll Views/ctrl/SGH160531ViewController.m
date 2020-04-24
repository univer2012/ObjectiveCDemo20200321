//
//  SGH160531ViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH160531ViewController.h"
#import <StoreKit/StoreKit.h>

@interface SGH160531ViewController ()<SKPaymentTransactionObserver, SKStoreProductViewControllerDelegate, SKProductsRequestDelegate>

@end

@implementation SGH160531ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UISegmentedControl *segmengedControl = ({
        UISegmentedControl *segmengedControl = [[UISegmentedControl alloc]initWithItems:@[@"普通登录", @"信用登录", @"个股期权"]];
        segmengedControl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 100, 40);
        segmengedControl.center = self.view.center;
        segmengedControl.selectedSegmentIndex = 0;
        [segmengedControl addTarget:self action:@selector(p_changeLoginType:) forControlEvents:UIControlEventValueChanged];
        segmengedControl;

    });
    [self.view addSubview:segmengedControl];
    
#if 0
    
    NSString *string = @"123456weixin.qq.com.comcom";
    if ([string rangeOfString:@"12345%"].location != NSNotFound) {
        //weixin.qq.com
        //12345%
        NSLog(@"包含 weixin.qq.com  字符串");
    }
    
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 70)];
    backgroundView.center = self.view.center;
    backgroundView.clipsToBounds = YES;
    backgroundView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:backgroundView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(30, 50, 80, 30);
    //CGRectMake(10, 40, 110, 40);
    button.layer.cornerRadius = button.frame.size.height / 2.0;
    button.clipsToBounds = YES;
    button.backgroundColor = [UIColor cyanColor];
    [backgroundView addSubview:button];
    
    
    ///0--Register Observer
    ///•Add an observer at launch
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    
    ///1--Load In-App Identifiers
    ///From within your app
    NSArray *productIdentifiers = @[@"com.myCompany.myApp.product1",
                                    @"com.myCompany.myApp.product2",
                                    @"com.myCompany.myApp.product3"];
    ///From your server
        ///Develop your own client/server communication
    
    ///2--Fetch Product Info
    NSSet *identifierSet = [NSSet setWithArray:productIdentifiers];
    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:identifierSet];
    
    request.delegate = self;
    [request start];
    
    ///3--Show In-App UI
    
    
    ///4--Make Pruchase
    SKProduct *product = [SKProduct new];
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
    ///5--Process Transaction
    
    ///6--Make Asset Available
        ///•Unlock functionality in your app
        ///•Download additional content from your server
    
    ///7--Finish Transaction
    SKPaymentTransaction *transaction = [SKPaymentTransaction new];
    [[SKPaymentQueue defaultQueue]finishTransaction:transaction];

#endif
    
}

-(void)p_changeLoginType:(UISegmentedControl *)control {
    switch (control.selectedSegmentIndex) {
        case 0: {
            
        }
        break;
        case 1: {
            
        }
        break;
        case 2: {
            
        }
        break;
    }
}



#pragma mark - SKPaymentTransactionObserver
/// •Implement SKPaymentTransactionObserver protocol
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                //...
                break;
            case SKPaymentTransactionStateFailed:
                //...
                break;
            case SKPaymentTransactionStateRestored:
                //...
                break;
        }
    }
}

-(void)showProductViewController:(UIButton *)sender {
    SKStoreProductViewController *viewController = [[SKStoreProductViewController alloc]init];
    viewController.delegate = self;
    static NSInteger itemIdentifier = 30;
    NSDictionary *parameters = @{SKStoreProductParameterITunesItemIdentifier : [NSNumber numberWithInteger:itemIdentifier]};
    
    [viewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (result) {
            [[self.view.window rootViewController]presentViewController:viewController animated:YES completion:^{ }];
        }
    }];
}

#pragma mark - SKStoreProductViewControllerDelegate
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:^{ }];
}

#pragma mark - SKProductsRequestDelegate
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *products = response.products;
    NSArray *identifiers = response.invalidProductIdentifiers;
}
-(void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
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
