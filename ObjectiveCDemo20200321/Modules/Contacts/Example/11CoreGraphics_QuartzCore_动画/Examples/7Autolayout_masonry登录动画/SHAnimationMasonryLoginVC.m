//
//  SHAnimationMasonryLoginVC.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHAnimationMasonryLoginVC.h"
#import "Masonry/Masonry.h"
#import "HomePageAnimationUtil.h"

@interface SHAnimationMasonryLoginVC ()
@property(nonatomic,weak)UILabel *topTitleLabel;
@property(nonatomic,weak)UILabel *bottomTitleLabel;

@property(nonatomic,assign)UIImageView *login_textFieldBottomLine;
@property(nonatomic,weak)UIImageView *phoneIconImageView;
@property(nonatomic,weak)UITextField *phontTextField;

@property(nonatomic,weak)UIButton *loginButton;

@property(nonatomic,weak)UILabel *topTipsLabel;
@property(nonatomic,strong)UIView *bottomTipsView;

@end

@implementation SHAnimationMasonryLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self p_setUpViews];
    
    _topTitleLabel.transform=CGAffineTransformMakeTranslation(0, -200);
    _bottomTitleLabel.transform=CGAffineTransformMakeTranslation(0, -200);
    _phoneIconImageView.transform=CGAffineTransformMakeTranslation(-200, 0);
    
    [self.phontTextField.rac_textSignal subscribeNext:^(id x) {
        if (self.phontTextField.text.length == 11) {
            self.loginButton.userInteractionEnabled=YES;
        } else {
            self.loginButton.userInteractionEnabled=NO;
        }
        CGFloat progress = self.phontTextField.text.length/11.0;
        [HomePageAnimationUtil registerButtonWidthAnimation:self.loginButton withView:self.view andProgress:progress];
    }];
    
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [HomePageAnimationUtil titleLabelAnimationWithLabel:_topTitleLabel withView:self.view];
    [HomePageAnimationUtil titleLabelAnimationWithLabel:_bottomTitleLabel withView:self.view];
    [HomePageAnimationUtil phoneIconAnimationWithLabel:_phoneIconImageView withView:self.view];
    [HomePageAnimationUtil textFieldBottomLineAnimationWithConstraintView:self.login_textFieldBottomLine WithView:self.view];
    
    [HomePageAnimationUtil tipsLabelMaskAnimation:_topTipsLabel withBeginTime:0];
    [HomePageAnimationUtil tipsLabelMaskAnimation:_bottomTipsView withBeginTime:1];
    
    
}

-(void)p_setUpViews {
    UILabel *topTitleLabel=({
        UILabel *label=[UILabel new];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(85.0);
            make.centerX.equalTo(self.view);
        }];
        label.text=@"嘿，Coder";
        
        label;
    });
    self.topTitleLabel=topTitleLabel;
    
    UILabel *bottomTitleLabel=({
        UILabel *label=[UILabel new];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topTitleLabel.mas_bottom).offset(5.0);
            make.centerX.equalTo(self.view);
        }];
        label.text=@"请输入手机号码";
        
        label;
    });
    self.bottomTitleLabel=bottomTitleLabel;
    //输入框
    UITextField *phontTextField=({
        UITextField *textField=[UITextField new];
        [self.view addSubview:textField];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@290.0).priorityLow();
            make.height.equalTo(@30);
            make.centerX.equalTo(self.view);
            make.top.lessThanOrEqualTo(bottomTitleLabel.mas_bottom).offset(100);
            
        }];
        textField.borderStyle=UITextBorderStyleRoundedRect;
        
        textField;
    });
    self.phontTextField = phontTextField;
    
    //手机图片
    UIImage *phoneImage = [UIImage imageNamed:@"mobile_icon"];
    UIImageView *phoneIconImageView=({
        UIImageView *imageView=[UIImageView new];
        imageView.image = phoneImage;
        [self.view addSubview:imageView];
        imageView;
    });
    [phoneIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phontTextField);
        make.left.greaterThanOrEqualTo(self.view).offset(15.0);
        make.right.equalTo(phontTextField.mas_left).offset(-13.0);
        make.height.equalTo(phontTextField);
        //make.width.equalTo(phoneIconImageView.mas_height).multipliedBy(phoneImage.size.width/phoneImage.size.height); //FIXME:没有注释会崩溃
    }];
    [phoneIconImageView sizeToFit];
    self.phoneIconImageView = phoneIconImageView;
    //横线
    UIImageView *login_textFieldBottomLine = ({
        UIImageView *imageView=[UIImageView new];
        imageView.image =[UIImage imageNamed:@"login_textfield_bottomline"];
        [self.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(phoneIconImageView.mas_bottom).offset(16.0);
            //            make.size.mas_equalTo(CGSizeMake(345, 1));
            make.height.equalTo(@1);
            make.width.equalTo(@0);
            //            make.left.equalTo(phoneIconImageView);
            //            make.right.lessThanOrEqualTo(self.view).offset(-15.0);
        }];
        imageView;
    });
    self.login_textFieldBottomLine=login_textFieldBottomLine;
    
    //登录 按钮
    UIButton *loginButton=({
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(login_textFieldBottomLine.mas_bottom).offset(32.0);
            make.size.mas_equalTo(CGSizeMake(145, 44));
        }];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor=[UIColor blueColor];
        [button addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    self.loginButton=loginButton;
    
    //第一行文字
    UILabel *topTipsLabel=({
        UILabel *label=[UILabel new];
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(loginButton.mas_bottom).offset(14.0);
        }];
        label.text=@"登陆/注册请仔细阅读";
        label.font=[UIFont systemFontOfSize:12];
        label;
    });
    self.topTipsLabel=topTipsLabel;
    
    // ============================= 第二行文字
    UIView *bottomTipsView=({
        UIView *view=[UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(topTipsLabel.mas_bottom).offset(8.0);
            make.width.equalTo(topTipsLabel);
            make.height.equalTo(topTipsLabel);
        }];
        view;
    });
    self.bottomTipsView=bottomTipsView;
    
    UIButton *bottomTipsLeftButton=({
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [bottomTipsView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomTipsView);
        }];
        [button setTitle:@"服务条款" forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button;
    });
    UILabel *heLabel=({
        UILabel *label=[UILabel new];
        [bottomTipsView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomTipsLeftButton.mas_right).offset(2.0);
            make.center.equalTo(bottomTipsView);
        }];
        label.text=@"和";
        label.textColor=[UIColor grayColor];
        label.font=[UIFont systemFontOfSize:12];
        label;
    });
    
    UIButton *bottomTipsRightButton=({
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [bottomTipsView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomTipsView);
            make.left.equalTo(heLabel.mas_right).offset(2.0);
        }];
        [button setTitle:@"许可协议" forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        button;
    });
    
}
-(void)clickLoginButton:(UIButton *)button {
    NSLog(@"登录");
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
