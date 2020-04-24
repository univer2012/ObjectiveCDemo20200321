//
//  SGHShowHTMLViewController.m
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/4/5.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHShowHTMLViewController.h"

@implementation SGHShowHTMLViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    NSString * htmlString = @"<html><body> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    UILabel * myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)/2.0)];
    myLabel.center = self.view.center;
    myLabel.backgroundColor=[UIColor yellowColor];
    myLabel.attributedText = attrStr;
    [self.view addSubview:myLabel];
    
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
