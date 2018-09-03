## C#历史迭代的特性(从最新的C#7.0以下排序)

### C#7.0 (对应Visual Studio 2017)

- 数字格式改进

 C#7中的数字类型可以包含下划线,以提高可读性.这些下划线被称为数字分隔符,会被编译器忽略.

 `int million = 1_000_000; `

  可以使用0b前缀指定二进制格式数字

 ` var b = ob1010_1011_1100_1101_1110_1111 ;`

- out 变量的声明

 C#7使调用包含out参数的方法变的容易.现在您可以动态的声明out变量:
 ```
   var i = int.TryParse("123", out int result);
   Console.WriteLine(result);
 ```

 当调用具有多个out参数的方法时,您可以使用下划线字符丢弃不感兴趣的变量:

 ```
 SomeBigMethod（out _，out _，out _， out int x ，out _，out _，out _）;
Console.WriteLine（x）;
 ```
- 模式变量
 您可以使用is动态的引入变量.这些被成为模式变量

 ```
 void Foo（object x）
{
  if（x is string s）
    Console.WriteLine（s .Length）;
}
 ```
 使用Switch时支持模式变量,这样你就可以判断类型.可以使用when指定条件,也可以使用null作为条件
 需注意的是,使用模式变量进行判断时候,需注意作为参数的类型是否可以隐式转换为判断的类型.
 ```
 object x="123";
  Switch(x)
  {
    case int i :
      Console.WriteLine("i is int");
      break;
    case string i :
      Console.WriteLine("i is String");
      break;
    case bool i when i==true:
      Console.WriteLine("i is BoolLean")
      break;
    case null :
      Console.WriteLine("i is null");
      break;
  }
 ```

- 本地方法:

   本地方法是在一个函数内声明的方法,作用域只在当前代码块中.
   ```
   void WriteCubes(){
     Console.WriteLine (Cube (3));
     Console.WriteLine (Cube (4));
     Console.WriteLine (Cube (5));

     int Cube(int value)=> value*value*value;
   }
   ```
- =>表达式的新成员:

  C#6中,添加了为方法,只读属性,运算符和索引器引入了表达式的 => 语法,C#7中,将其拓展成构造函数,读/写属性和终结器
  ps:终结器=C++中的析构函数

  -> 索引器:https://docs.microsoft.com/zh-cn/dotnet/csharp/programming-guide/indexers/

  -> 终结器:https://www.cnblogs.com/xiaojintao/p/6547988.html

  ```
  public class Person{
    string name;

    public Person(string name) => Name=name;                //构造函数

    public string Name{
      get => name;
      set => name=value ?? ""
    }

    ~Person() => Console.WriteLine("Function is Finalize"); // 终结器

  }
  ```

  -解构函数 or 解构器)
  //ToDo:待使用后补充修改
    C#7中引入了析构函数模式.构造函数通常使用一组值(作为参数)并将它们分配给字段,而析构函数则执行相反的操作并将字段拆分成一组变量.

 -> C#中析构函数与终结器 https://stackoverflow.com/questions/1872700/the-difference-between-a-destructor-and-a-finalizer

 -> 详细解释C#析构函数
https://andrewlock.net/deconstructors-for-non-tuple-types-in-c-7-0/
    ```
    public void Deconstruct（out string firstName，out string lastName）
    {
      int spacePos = name.IndexOf（''）;
      firstName = name.Substring（0，spacePos）;
      lastName = name.Substring（spacePos + 1）;
    }
    ```
使用以下特殊语法调用解构器:

   ```
  var joe = new Person ("Joe Bloggs");

  var (first, last) = joe;          // Deconstruction

  Console.WriteLine (first);        // Joe

  Console.WriteLine (last);         // Bloggs

   ```
- 元组 Tuples

  也许这是最显著的改进,C#7开始明确支持元组.元组提供了一种存储一组相关值的简单方法:

  ```
  var bob = （“Bob”，23） ;
  Console.WriteLine（bob.Item1）; // Bob
  Console.WriteLine（bob.Item2）; // 23
  ```

  C#中的新元组是使用System.ValueTuple<...>通用解构的语法糖.但感谢编译器,元组元素可以命名为:

  ```
var tuple = (Name:"Bob", Age:23);
Console.WriteLine (tuple.Name);     // Bob
Console.WriteLine (tuple.Age);      // 23
```

  使用元组,函数可以返回多个值而无需求助与out参数:

  ```
  static （int row，int column） GetFilePosition（）=> （ 3,10 ） ;

  static void Main（）
  {
  var pos = GetFilePosition（）;
  Console.WriteLine（pos .row）; // 3
  Console.WriteLine（pos .column）; // 10
  }
```

- 声明异常
  在C#7以前,throw是一个声明.现在它可以作为一个表达式出现:

  ```
  public string Foo（）=> throw new NotImplementedException（） ;
```

  throw表达式也可以在三元表达式中出现:

  ```
  string Capitalize (string value) =>
  value == null ? throw new ArgumentException ("value") :
  value == "" ? "" :
  char.ToUpper (value[0]) + value.Substring (1);
```


### C# 6.0 (对应Visual Studio 2015)

- '?.' 语法糖

   在调用一个方法或访问成员之前,明确的检查是否为null.在以下实例中,result的值为null而不是刨除NullReferenceException异常:
   ```
   String.Text.StringBulider sb=null;
   string result=sb?.ToString();
   ```
- 表达式函数

  允许以Lambda表达式的形式更简洁的编写包含单个表达式的方法、属性、运算符和所引起:

  ```
  public int TimesTwo (int x) => x*2;
  public string SomeProperty => "Property Value" ;
  ```

- 属性初始值

  允许对属性分配初始值:

  ```
  public DateTime TimeCreated {get;set;} = DateTime.Now;
  ```

  只读的属性也可以分配初始值
  ```
  public DateTime TimeCreated {get;} = DateTime.Now;

  ```

  还可以在构造函数中设置只读属性,从而共容易创建不可变(只读)类型的属性.

- 索引初始值

```
var dict=new Dictionary<int,string>(){
  [3]="123",
  [10]="456"
};
```
- 字符串中插入值 ,提供了一个简洁的替代String,Format方法:

```
string s = $ "...{...}";
```

- 异常过滤器 允许将when条件应用于catch块:

```
string html;
try {
  html=new WebClient().DownLoadString("Http://sfsfds");
}
catch (WebException Ex) when (ex.Status==WebExceptionStatus.Timeout){
  //...DoSomeThing
}
```

- 使用Using Static 引用一个类型的所有静态成员

```
using static System.Console;
//...DoSomeThing
WriteLine("Hello World"); 省略了Console.WriteLine

```

- NameOf函数

  nameof函数返回一个变量,类型,或其他符号作为字符串的名称.避免在Visual Studio 中重命名符号时破坏代码

```
int capacity = 123;
string x=nameof(capacity); // x is "capacity"
string y=nameof(Uri.Host); // y is "capacity"
```

### C# 5.0 (对应Visual Studio 2012)

C#5.0中最重要的新功能,通过两个新的关键字,支持异步函数.async和await.异步函数支持异步延续,这使得编写响应式和线程安全的客户端应用变得更加容易.可以编写出高度并发,且高效的I/O应用程序,这些应用程序不会为每个操作占用线程资源.

...略,后面补充

### C# 4.0 (对应Visual Studio 2010)
