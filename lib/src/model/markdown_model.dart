
class MdModel {
  int id;
  String? title;
  String? subTitle;
  String? author;
  List<String>? keyWords;
  String? date;
  String? topicImg;
  String? content;

  MdModel({
    required this.id,
    required this.title,
    this.subTitle = "",
    required this.author,
    this.keyWords = const [],
    required this.date,
    required this.topicImg,
    this.content = 'none'
  });

  // MdModel.about({
  //   this.id = 99,
  //   this.title="关于本站",
  //   this.subTitle = " ",
  //   this.author = "本站",
  //   this.keyWords = const ["Key1,Key2"],
  //   this.date = "2024-4-23",
  //   this.topicImg = "assets/img/default.jpg",
  //   this.content = '#### 本网站在国家自然科学基金委员会《关于新时代加强科学普及工作的意见》的指导下，依托国家自然科学基金重点项目《工业信息物理系统智能物联与综合安全》建立，力求让基础研究走进社会、让社会理解基础研究。'
  //
  // });
  MdModel.test({
    this.id = 999,
    this.title="Title",
    this.subTitle = "SubTitle",
    this.author = "Author",
    this.keyWords = const ["Key1,Key2"],
    this.date = "2023-5-5",
    this.topicImg = "assets/img/img1.png",
    this.content = "# About \n #### Febr 15, 2021 \n #### ABOUT,EN \n #### 23 \n ## Welcome \n Welcome to this template"
  });


  @override
  String toString() {
    return 'Title: $title\n'
        'Subtitle: $subTitle\n'
        'Author: $author\n'
        'Keywords: $keyWords\n'
        'Published: $date\n'
        'Topic Image: $topicImg\n'
        'Content: ${content?.substring(0,20)}...';
  }

}

