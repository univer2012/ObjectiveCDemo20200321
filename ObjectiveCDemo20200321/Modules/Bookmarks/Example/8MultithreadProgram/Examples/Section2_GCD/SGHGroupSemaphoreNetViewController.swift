//
//  SGHGroupSemaphoreNetViewController.swift
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/8.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

class SGHGroupSemaphoreNetViewController: SHBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.type = .method

        //MARK: section 1
        let tempTitleArray = [
            "1.使用dispatch_group_async + dispatch_group_notify实现异步和任务完成的通知。\n 内部是同步操作，没有网络请求",
            "2.使用dispatch_async + dispatch_barrier_async实现异步和任务完成的通知。\n async内部是同步操作，没有网络请求",
        ]
        let tempSelectorArray = [
            "demo1",
            "barrier",
        ]
        self.addSectionData(withClassNameArray: tempSelectorArray, titleArray: tempTitleArray, title: "async内部是同步操作，没有网络请求")
        
        //MARK: section 2
        let tempTitleArray2 = [
            "方法一、使用dispatch_semaphore_t",
            "方法二、使用GCD的 `dispatch_group_enter` + `dispatch_group_leave`",
            "方法三、回调中执行",
        ]
        let tempSelectorArray2 = [
            "serialBySemaphore",
            "serialByGroupWait",
            "serialByCallBack",
        ]
        self.addSectionData(withClassNameArray: tempSelectorArray2, titleArray: tempTitleArray2, title: "异步中顺序执行")

        //MARK: section 3
        let tempTitleArray3 = [
            "方式一：使用信号量 dispatch_semaphore_t",
            "方法二、使用GCD的 `dispatch_group_enter` + `dispatch_group_leave`",
        ];
        let tempSelectorArray3 = [
            "concurrentBySemaphore",
            "concurrentByGroup",
        ];
        self.addSectionData(withClassNameArray: tempSelectorArray3, titleArray: tempTitleArray3, title: "异步同时执行")

        //MARK: section 4
        let tempTitleArray4 = [
            "1.GCD + 信号量方式",
            "2.GCD + group enter/leave 方式",
        ]
        let tempSelectorArray4 = [
            "concurrentTest1",
            "concurrentTest2",
        ]
        self.addSectionData(withClassNameArray: tempSelectorArray4, titleArray: tempTitleArray4, title: "模拟循环网络请求 - 异步执行、统一通知完成")

        //MARK: section 5
        let tempTitleArray5 = [
            "1.GCD + 信号量方式",
            "2.GCD + group enter/leave 方式",
        ]
        let tempSelectorArray5 = [
            "serialTest1",
            "serialTest2",
        ]
        self.addSectionData(withClassNameArray: tempSelectorArray5, titleArray: tempTitleArray5, title: "模拟循环网络请求 - 异步中顺序执行")
        
        //MARK: section 6
        let tempTitleArray6 = [
            "1.执行多个`queue.async(group: , execute:)`，block里是网络请求， 网络请求都完成之后执行`group.notify(queue:, execute:)`，应该怎么办？",
            "2.下面的代码会出现什么情况，会打印吗？",
        ]
        let tempSelectorArray6 = [
            "sec6demo1",
            "sec6demo2",
        ]
        self.addSectionData(withClassNameArray: tempSelectorArray6, titleArray: tempTitleArray6, title: "面试题")

        self.tableView.reloadData()
    
    }
    //MARK: 2.下面的代码会出现什么情况，会打印吗？
    //答：不会打印，因为信号量为0
    @objc func sec6demo2() {
        #if false
        let sem = DispatchSemaphore(value: 1)
        sem.wait()    //信号量减1
        print("next")
        //说明：会打印，但是也会崩溃，原因是wait 和 signal 没有成对出现。
        
        #elseif false
        
        let sem = DispatchSemaphore(value: 1)
        sem.wait()    //信号量减1
        print("next")
        sem.signal() //信号量加1
        //说明：会打印，不会崩溃。
        
        #elseif true
        
        let sem = DispatchSemaphore(value: 0)
        sem.wait()    //信号量减1
        print("next")
        //说明：不会打印，不会崩溃，但会卡死整个app。
        
        #elseif false
        
        let sem = DispatchSemaphore(value: 0)
        print("next")
        //说明：会打印，不会崩溃，不会卡死。
        
        #elseif false
        
        let sem = DispatchSemaphore(value: 0)
        sem.signal()
        sem.wait()
        print("next")
        //说明：会打印，不会崩溃，不会卡死。
        #endif
        
        
        
        
        
    }
    
    //MARK: - section 6
    //MARK: 1.执行多个`queue.async(group: , execute:)`，block里是网络请求， 网络请求都完成之后执行`group.notify(queue:, execute:)`，应该怎么办？
    //描述：是异步执行，
    @objc func sec6demo1() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        
        print("start")
        queue.async(group: group, execute: {
            group.enter()
            //模拟网络请求
            queue.async {
                sleep(3)
                print("request_1")
                group.leave()
            }
        })
        
        queue.async(group: group, execute: {
            group.enter()
            //模拟网络请求
            queue.async {
                sleep(2)
                print("request_2")
                group.leave()
            }
        })
        
        queue.async(group: group, execute: {
            group.enter()
            //模拟网络请求
            queue.async {
                sleep(1)
                print("request_3")
                group.leave()
            }
        })
        
        group.notify(queue: queue, execute: {
            print("task finish")
        })
    }
    
    //MARK: 2.GCD + group enter/leave 方式
    @objc func serialTest2() {
        let group = DispatchGroup()
        for i in 0 ..< 5 {
            group.enter()
            print("开始\(i)")
            // 模拟请求 ↓
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                sleep(UInt32(6 - i))
                print("任务\(i)完成")
                group.leave()
            }
            // 模拟请求 ↑
            group.wait() // 顺序执行与同步执行的不同点
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("全部搞完了")
        }
    }

    
    //MARK: - section 5、模拟循环网络请求 - 异步中顺序执行
    //MARK: 1.GCD + 信号量方式
    @objc func serialTest1() {
        let sema = DispatchSemaphore(value: 0)
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
            for i in 0 ..< 5 {
                print("开始\(i)")
                // 模拟请求 ↓
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                    sleep(3)
                    print("任务\(i)完成")
                    sema.signal()
                }
                // 模拟请求 上
                sema.wait()
            }
            
            print("全部搞完了")
        })
    }

    
    //MARK: 2.GCD + group enter/leave 方式
    @objc func concurrentTest2() {
        let group = DispatchGroup()
        for i in 0 ..< 5 {
            group.enter()
            print("开始\(i)")
            // 模拟请求 ↓
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                sleep(3)
                print("任务\(i)完成")
                group.leave()
            }
            // 模拟请求 ↑
        }
        
        group.notify(queue: DispatchQueue.main) {
            print("全部搞完了")
        }
    }

    
    //MARK: - section 4、模拟循环网络请求 - 异步执行、统一通知完成
    //MARK: 1.GCD + 信号量方式
    @objc func concurrentTest1() {
        let group = DispatchGroup()
        for i in 0 ..< 5 {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(group: group, execute: {
                let sema = DispatchSemaphore(value: 0)
                print("开始\(i)")
                // 模拟请求 ↓
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {
                    sleep(3)
                    print("任务\(i)完成")
                    sema.signal()
                })
                // 模拟请求 上
                sema.wait()
            })
        }
        group.notify(queue: DispatchQueue.main, execute: {
            print("全部搞完了")
        })
    }

    
    //MARK: 方法二、使用GCD的 `dispatch_group_enter` + `dispatch_group_leave`
    @objc func concurrentByGroup() {
        let group = DispatchGroup()
        
        group.enter()
        self.requestOneWith(successBlock: {
            group.leave()
        })
        
        group.enter()
        self.requestTwoWith(block: {
            group.leave()
        })
        
        // 1 2  都完成 才会执行
        group.notify(queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default), execute: {
            print("all request  done!")
        })
    }

    
    //MARK: - section 3 异步同时执行
    //MARK: 方式一：使用信号量 dispatch_semaphore_t
    @objc func concurrentBySemaphore() {
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(group: group, execute: {
            let sema = DispatchSemaphore(value: 0)
            self.requestOneWith(successBlock: {
                sema.signal()
            })
            sema.wait()
        })
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(group: group, execute: {
            let sema = DispatchSemaphore(value: 0)
            self.requestTwoWith(block: {
                sema.signal()
            })
            sema.wait()
        })
        
        group.notify(queue: DispatchQueue.main, execute: {
            print("全部搞完了")
        })
        
    }

    
    //MARK: 方法三、回调中执行
    ///low方法，请求一多，嵌套恶心
    @objc func serialByCallBack() {
        self.requestOneWith(successBlock: {
            self.requestTwoWith(block: {
                
            })
        })
    }

    
    //MARK: 方法二、使用GCD的 `dispatch_group_enter` + `dispatch_group_leave`
    ///1、2 同时执行，执行完了再执行3
    @objc func serialByGroupWait() {
        let group = DispatchGroup()
        
        group.enter()
        self.requestOneWith(successBlock: {
            group.leave()
        })
        
        group.enter()
        self.requestTwoWith(block: {
            group.leave()
        })
        // 1  2同时执行
        
        group.wait() // 1 2 执行完 下面才会执行
        
        group.enter()
        self.requestThreeWith(block: {
            group.leave()
        })
        
        // 1 2 3 都完成 才会执行
        group.notify(queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default), execute: {
            print("all request  done!")
        })
    }

    
    func requestThreeWith( block finished: @escaping ()->()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            sleep(1)
            print("Three")
            finished()
        }
    }
    
    
    //MARK: - section 2异步中顺序执行
    //MARK: 方法一、使用dispatch_semaphore_t
    @objc func serialBySemaphore() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let semaphore = DispatchSemaphore(value: 0)
            
            self.requestOneWith(successBlock: {
                semaphore.signal()
            })
            
            semaphore.wait()
            
            self.requestTwoWith(block: {
                
            })
        }
    }


    func requestTwoWith( block finished: @escaping ()->()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            sleep(2)
            print("Two")
            finished()
        }
    }

    func requestOneWith(successBlock finished: @escaping ()->()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            sleep(3)
            print("One")
            finished()
        }
    }

    
    
    //MARK: 2.使用dispatch_async + dispatch_barrier_async实现异步和任务完成的通知。\n async内部是同步操作，没有网络请求
    @objc func barrier() {
        //let queue = DispatchQueue.init(label: "com.lai.www")
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        
        queue.async {
            print("任务1-1完成")
        }
        queue.async {
            print("任务1-2完成")
        }
        queue.async {
            print("任务1-3完成")
        }
        
        queue.async(flags: .barrier) {
            print("以上任务都完成 dispatch_barrie完成")
        }
        
    }
    

    //MARK: 1.使用dispatch_group_async + dispatch_group_notify实现异步和任务完成的通知。\n 内部是同步操作，没有网络请求
    
    @objc func demo1() {
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let group = DispatchGroup()
        
        queue.async(group: group, execute: {
            print("任务一完成")
        })
        
        queue.async(group: group, execute: {
            print("任务二完成")
        })
        
        queue.async(group: group, execute: {
            print("任务三完成")
        })
        //在分组的所有任务完成后触发
        group.notify(queue: queue, execute: {
            print("所有任务完成")
        })
    }
    
    deinit {
        print("SGHGroupSemaphoreNetViewController_deinit")
    }
}
