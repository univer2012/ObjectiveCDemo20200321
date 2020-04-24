//
//  SGH1125XMLParserViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/11/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1125XMLParserViewController.h"

#import "TBXML.h"


@interface SGH1125XMLParserViewController ()<NSXMLParserDelegate>
{
    NSMutableDictionary *_dataDict;
 
    NSMutableArray *_parserObjects;
    NSMutableString *element;
}


@end

@implementation SGH1125XMLParserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self p_testTBXMLBooks];
    
    [self p_testTBXMLServer];
}

-(void)p_testTBXMLServer {
    NSError *error;
    
#if 1
    ///获取文件的路径
    NSString *serverPath = [[NSBundle mainBundle]pathForResource:@"Server_RTDev" ofType:@"xml"];
    //获取属性列表文件中的全部数据
    //NSDictionary *plistDictionary = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    NSString *serverString = [[NSString alloc]initWithContentsOfFile:serverPath encoding:NSUTF8StringEncoding error:nil];
    
    TBXML *tbxml = [[TBXML alloc]initWithXMLString:serverString error:&error];
    
#elif 0
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLFile:@"Server_RTDev.xml" error:&error];
    
#endif
    
    if (error) {
        NSLog(@"%@ %@", [error localizedDescription], [error userInfo]);
    }
    else {
        TBXMLElement *root = tbxml.rootXMLElement;
        TBXMLElement *room = [TBXML childElementNamed:@"room" parentElement:root];
        NSString *mainsite = [TBXML valueOfAttributeNamed:@"mainsite" forElement:room];
        NSLog(@"mainsite : %@", mainsite);
    }
}


-(void)p_testTBXMLBooks {
    NSError *error;
    TBXML * tbxml = [TBXML newTBXMLWithXMLFile:@"books.xml" error:&error];
    
    if (error) {
        NSLog(@"%@ %@", [error localizedDescription], [error userInfo]);
    } else {
        //NSLog(@"%@", [TBXML elementName:tbxml.rootXMLElement]);
        TBXMLElement *root = tbxml.rootXMLElement;
        TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:root];
        NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:author];
        NSLog(@"author : %@", name);
        TBXMLElement *book = [TBXML childElementNamed:@"book" parentElement:author];
        TBXMLElement *descriptionElem = [TBXML childElementNamed:@"description" parentElement:book];
        NSString * description = [TBXML textForElement:descriptionElem];
        NSLog(@"description : %@", description);
    }
    
    
}



-(void)p_testNSXMLParser {
    element = [[NSMutableString alloc]init];
    //bundle是一个目录，包含了程序会使用到的资源
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Server_RTDev" ofType:@"xml"];
    NSString *_xmlContent=[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser *parse=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    [parse setDelegate:self];
    BOOL flag = [parse parse];
    if (flag) {
        NSLog(@"解析成功");
    }
    else {
        NSLog(@"解析解析失败");
    }
}


#pragma mark - NSXMLParserDelegate
//第一个代理方法：
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //判断是否是meeting
    if ([elementName isEqualToString:@"meeting"]) {
        //判断属性节点
        if ([attributeDict objectForKey:@"addr"]) {
            //获取属性节点中的值
            NSString *addr = [attributeDict objectForKey:@"addr"];
            NSLog(@"addr: %@", addr);
        }
    }
    //判断member
    if ([elementName isEqualToString:@"member"]) {
        NSLog(@"member");
    }
}


//第二个代理方法：
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //获取文本节点中的数据，因为下面的方法要保存这里获取的数据，所以要定义一个全局变量(可修改的字符串)
    //NSMutableString *element = [[NSMutableString alloc]init];
    //这里要赋值为空，目的是为了清空上一次的赋值
    [element setString:@""];
    [element appendString:string];//string是获取到的文本节点的值，只要是文本节点都会获取(包括换行)，然后到下个方法中进行判断区分
}

//第三个代理方法：
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSString *str=[[NSString alloc] initWithString:element];
    
    if ([elementName isEqualToString:@"creator"]) {
        NSLog(@"creator=%@",str);
    }
    if ([elementName isEqualToString:@"name"]) {
        NSLog(@"name=%@",str);
    }
    if ([elementName isEqualToString:@"age"]) {
        NSLog(@"age=%@",str);
    }
    //[str release];
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
