# AddressBook
通讯录（提供通讯录数组按字母顺序排序）
##使用方法
* 导入头文件`#import "ChineseString.h"` 
* 定义两个数组，一个数组用来接收中文转换后字符索引，一个数组用来接收按字母排序后的结果数组
    
		_nameArr = @[@"李灵黛",@"冷文卿",@"阴露萍",@"柳兰歌",@"秦水支",@"李念儿",@"文彩依",@"柳婵诗",@"顾莫言",@"任水寒",@"金磨针",@"丁玲珑",@"凌霜华",@"水笙",@"容柒雁"];
		接收中文转换后字符索引；
   		self.indexArray = [ChineseString IndexArray:_nameArr];
   		按字母排序后的结果数组
   		self.letterResultArr = [ChineseString LetterSortArray:_nameArr];
    
