import UIKit





//// MARK: - Swift中的指针
///*
// 在Swift中指针是不安全的
// 在Swift中，对象的生命周期由引用计数机制进行管理。但是当我们使用指针访问对象时对象的引用计数并没有改变，因此可能出现不安全的操作，这从指针结构体的名字也可以看出，他们都是以Unsafe开头的。
// */
//
//// 示例
//var a = 10
//var b = 10
//b += 1
//// 值类型，a = 10 b = 11
//// 新建一个指向a的指针，使其共享一个数据
//var a_p:UnsafeMutablePointer<Int> = withUnsafeMutablePointer(to: &a) { (pointer) -> UnsafeMutablePointer<Int> in
//    return pointer
//}
//print(a) // a的值10
//print(a_p.pointee) // 指针a_p指向的数据a的值10
//print(a_p) // 指针a_p本身的值，是一个地址0x0000000103803090
//a_p.pointee = 11 // 修改指针a_p指向的数据a的值
//print(a) // a的值11
//print(a_p.pointee) // 指针a_p指向的数据a的值11
//print(a_p) // 指针a_p本身的值，是一个地址0x0000000103803090
//
//func update0(data:Int) {
//    // data = data + 1 // 错误，此时data是声明为let的常量
//}
//// 解决办法一，把参数改为指针
//func update1(data:UnsafeMutablePointer<Int>) {
//    data.pointee = data.pointee + 1
//}
//update1(data: &a)
//print(a)
//// 解决办法2，使用inout
//func update2( data:inout Int) {
//    // data = data + 1 // 错误，此时data是声明为let的常量
//}
//update2(data: &a)
//print(a)
//// 二者原理是一样的
//
//// 手动创建指针
////状态1：内存没有被分配，此时指针对象为空指针。
////状态2：内存进行了分配，但是值未进行初始化。
////状态3：内存进行了分配，值也已经初始化完成。
//var p = UnsafeMutablePointer<Int>.allocate(capacity: 2) // 申请存放两个Int数据的内存
//p.initialize(to: 10) // 初始化第一个Int
//p[1] = 20
//print(p.pointee) // 第一个指向的值
//print(p.successor().pointee) // 下一个位置的值
//p.deinitialize(count: 2) // 析构
//p.deallocate() // 释放内存
//
//// 数组指针
//var array:Array<Int> = [1, 2, 3, 4, 5]
//var array_p = UnsafeBufferPointer<Int>(start: &array, count: array.count)
//if var base = array_p.baseAddress { // 基地址
//    var i = 0
//    while i < array_p.count {
//        print(base.pointee) // 内容
//        base = base.successor() // 获取下一个元素
//        i += 1
//    }
//}
//
//var array2:Array<Int>? = [1, 2, 3, 4, 5]
//var array_p2 = UnsafeBufferPointer<Int>(start: &array2!, count: array2!.count)
//array2 = nil // 释放array2内容，则array_p2变为野指针
//if var base2 = array_p2.baseAddress { // 基地址
//    var i = 0
//    while i < array_p2.count {
//        print(base2.pointee) // 内容
//        base2 = base2.successor() // 获取下一个元素
//        i += 1
//    }
//} // 会打印出乱七八糟的值
//
//
//class Teacher {
//    var name:String
//    var subject:String
//
//    init(name:String, subject:String) {
//        self.name = name
//        self.subject = subject
//    }
//}
//
//var t:Teacher? = Teacher(name: "Jaki", subject: "Swift")
////var t_p = withUnsafePointer(to: &t!) { (pointer) -> UnsafePointer<Teacher> in
////    return pointer
////}
////t = nil
////print(t_p.pointee.name)   // 会产生运行错误
//
//
//var t_un = Unmanaged.passRetained(t!) // 将t转换为非托管的对象t_un，t_un对象不受ARC引用计数的影响，需要自己控制
//var t_p = t_un.toOpaque() // 获取t_un的指针t_p
//t = nil // t置空
//var tt = unsafeBitCast(t_p, to: Teacher.self) // 把指针t_p强制转换为一个Teacher实例对象，得到tt
//print(tt.name)
//t_un.release() // 手动回收对象





//// MARK: - Swift中的String
//
///* 知识点1 自定义描述信息
// •CustomStringConvertible
// •CustomDebugStringConvertible
// */
//
//class Teacher: CustomStringConvertible {
//    var name:String
//
//    var description: String {
//        get {
//            return "教师对象:\(self.name)"
//        }
//    }
//
//    init(name:String) {
//        self.name = name
//    }
//}
//
//let t = Teacher(name: "Jaki")
//
//print(t)   // 教师对象:Jaki
//
//
///* 知识点2 字符串迭代器
// Iterator
// 与迭代有关的几个高级方法map、filter、reduce、flatmap、compactMap
// */
//
//var string = "Hello"
//var it:String.Iterator = string.makeIterator()
//while let c = it.next() {
//    print(c)
//}
//
//// 转化大写
//var newString1 = "Hello".map { (c) -> String in
//    return c.uppercased()
//}
//print(newString1.joined())
//
//// 过滤大写字符
//var newString2 = "Hello".filter { (c) -> Bool in
//    if c.asciiValue! <= "Z".first!.asciiValue! &&  c.asciiValue! >= "A".first!.asciiValue! {
//        return false
//    }
//    return true
//}
//print(newString2)
//
//// 累加器
//var newString3 = "Hello".reduce("xxx") { (result, c) -> String in
//    return result + "!" + String(c)
//
//}
//print(newString3) // xxx!H!e!l!l!o


//// MARK: - Swift中的Array（扩容两倍原则、写时复制技术）
//
//var array:Array<Int> = [1, 2, 3]
//// capacity获取数组的空间大小（扩容两倍原则）、count获取数组中元素的数量
//print(array.capacity)   // 3
//array.append(4)
//print(array.capacity)   // 6 扩容两倍
//array.append(contentsOf: [5, 6, 7])
//print(array.capacity)   // 12 扩容两倍
//array.append(contentsOf: [8, 9, 10, 11, 12, 13])
//print(array.capacity)   // 24 扩容两倍
//
//var array1 = [1, 2, 3]
//var array2 = array1
//print(array1, array2)
//// 写时复制技术
//// 道理上会进行深拷贝，但是为了优化内存，目前这两个数组对象的存储地址及内部数据是一样的
//// 直到array2发生了改变，这时候就会是两个不同的两个Array对象了
//array2.append(4)
//print(array1, array2)
//
//
//
//// MARK: - Swift中的Dictionary
//
//// 通过自定义的对象作为Dictionary的键key
//class Index: Hashable {
//
//    var value:Int
//
//    // hash对象
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(self.value)
//    }
//
//    // 重载等于==比较符
//    static func == (lhs:Index, rhs:Index) -> Bool {
//        return lhs.value == rhs.value
//    }
//
//    init(value:Int) {
//        self.value = value
//    }
//}
//
//var dic:Dictionary<Index, String> = [Index(value: 0) : "1", Index(value: 1) : "2", Index(value: 2) : "3"]
//print(dic)
//dic.updateValue("100", forKey: Index(value: 0))
//print(dic)
//
//print(dic.capacity)
//dic.updateValue("4", forKey: Index(value: 3))
//print(dic.capacity)
