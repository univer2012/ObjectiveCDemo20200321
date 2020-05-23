//
//  SGHDataStructAlgorithmsViewController+MRC.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/22.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGHDataStructAlgorithmsViewController+MRC.h"

@implementation SGHDataStructAlgorithmsViewController (MRC)

//MARK: 2.链表反转
/*
 反转前：1->2->3->4->NULL
 反转后：4->3->2->1->NULL
 */
/**  定义一个链表  */
struct Node {
    NSInteger data;
    struct Node * next;
};

- (void)listReverse {
    struct Node * p = [self constructList];
    
    [self printList:p];
    
    //反转后的链表头部
    struct Node * newH = NULL;
    //头插法
    while (p != NULL) {
        
        //记录下一个结点
        struct Node * temp = p->next;
        //当前结点的next指向新链表的头部
        p->next = newH;
        //更改新链表头部为当前结点
        newH = p;
        //移动p到下一个结点
        p = temp;
    }
    
    [self printList:newH];
}
/**
 打印链表

 @param head 给定链表
 */
- (void)printList:(struct Node *)head {
    struct Node * temp = head;
    
    printf("list is : ");
    
    while (temp != NULL) {
        
        printf("%zd ",temp->data);
        
        temp = temp->next;
    }
    
    printf("\n");
}


/**  构造链表  */
- (struct Node *)constructList {
    //头结点
    struct Node *head = NULL;
    //尾结点
    struct Node *cur = NULL;
    
    for (NSInteger i = 0; i < 10; i++) {
        
        struct Node *node = malloc(sizeof(struct Node));
        
        node->data = i;
        
        //头结点为空，新结点即为头结点
        if (head == NULL) {
            
            head = node;
            
        }else{
            //当前结点的next为尾结点
            cur->next = node;
        }
        
        //设置当前结点为新结点
        cur = node;
    }
    
    return head;
}

@end
