//
//  SGHSwiftProgramLanguageViewController.swift
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/14.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

class SGHSwiftProgramLanguageViewController: SHBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.type = .method

        //MARK: section 1
        let tempTitleArray = [
            "1.struct和class的区别",
            "2_1.property初始化的不同",
            "2_2、变量赋值方式不同（深浅copy）",
        ]
        let tempSelectorArray = [
            "sec1demo1",
            "sec1demo2_1",
            "sec1demo2_2",
        ]
        self.addSectionData(withClassNameArray: tempSelectorArray, titleArray: tempTitleArray, title: "swift")
        
        self.tableView.reloadData()
    }
    
    //MARK: 2_2、变量赋值方式不同（深浅copy）
    @objc func sec1demo2_2() {
        // struct
        let snode = SNode(Data: 4)
        //let snode1 = snode
        var snode1 = snode
        snode1.Data = 5
        print("snode.data:\(String(describing: snode.Data))\n snode1.data:\(String(describing: snode1.Data))")
        
        
        // class
        let cnode = CNode()
        cnode.Data = 5
        let cnode1 = cnode
        cnode1.Data = 6
        print("cnode.data:\(String(describing: cnode.Data))\n cnode1.data:\(String(describing: cnode.Data))")
    }
        
    //MARK: 2_1.property初始化的不同
    @objc func sec1demo2_1() {
        let snode = SNode(Data: 4) // struct可直接在构造函数中初始化property
        print("snode.data:\(String(describing: snode.Data))")


        let cnode = CNode()  // class不可直接在构造函数中初始化property
        cnode.Data = 5
        print("cnode.data:\(String(describing: cnode.Data))")
    }
    
    //MARK: 1.struct和class的区别
    @objc func sec1demo1() {
        
        print("class ==========")
        let aTest = ClassTest()
        
        print("number is \(aTest.number)")
        print("name is \(aTest.name)")
        /*output:
         number is 0
         name is test
         */

        let bTest = aTest
        bTest.number = 5
        bTest.name = "testAAA"
        //改变了bTest中的值。由于类是引用类型，相对于的aTest中的值也会被改变
        
        print("number is \(aTest.number)")
        print("number is \(aTest.name)")
        /*output:
         number is 5
         number is testAAA
         */
        
        print("struct ==========")
        print("改变前：")
        let aStruct = StructTest()
        print(aStruct.number)
        print(aStruct.name)
        /*output:
         改变前：
         1
         struct
         */
        
        var bStruct = aStruct
        bStruct.number = 10
        bStruct.name = "myTestStruct"
        
        print("改变后：bStruct")
        print(bStruct.number)
        print(bStruct.name)
        /*output:
         改变后：bStruct
         10
         myTestStruct
         */
        
        print("改变后：aStruct")
        print(aStruct.number)
        print(aStruct.name)
        /*output:
         改变后：aStruct
         1
         struct
         */
    }

}


fileprivate struct SNode {
    var Data: Int?
}
extension SNode {
    
    mutating func changeData(value: Int) {
        self.Data = value
    }
}

fileprivate class CNode {
    var Data: Int?
}
extension CNode {
    func changeData(value: Int) {
        self.Data = value
    }
}





extension StructTest {
    //var littleName: String = "Sam" //不可以扩展属性
    func eat() {
        print("struct eat")
    }
}

fileprivate struct StructTest {
  var number:Int = 1
  var name:String = "struct"
}

fileprivate class ClassTest {
    
  var number: Int = 0
    
  var name: String = "test"
}
