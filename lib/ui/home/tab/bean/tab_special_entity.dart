/// code : 200
/// msg : "操作成功"
/// info : {"type_list":[{"id":1,"title":"药企专题","dataFlag":1,"sorts":50,"lists":[{"id":6,"title":"山东汉方制药有限公司","image":"https://cdn3.yaoqiyuan.com/uploads/20190820/5d5b8deb84406.jpg","descs":null}]}],"banner_list":[{"id":154,"img":"https://cdn3.yaoqiyuan.com/uploads/business/20200409/7fcc0ed0e8d54f00394a69021bb55078.png","name":"医学专题顶部Banner","url":"https://m.yaoqiyuan.com/special/info.html?id=6","adv_type":0,"art_id":6,"pc_route":null,"m_route":null,"route":null}]}

class InfoBean {
  int code;
  String msg;
  Info info;

  InfoBean({this.code, this.msg, this.info});

  InfoBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class Info {
  List<TypeList> typeList;
  List<BannerList> bannerList;

  Info({this.typeList, this.bannerList});

  Info.fromJson(Map<String, dynamic> json) {
    if (json['type_list'] != null) {
      typeList = new List<TypeList>();
      json['type_list'].forEach((v) {
        typeList.add(new TypeList.fromJson(v));
      });
    }
    if (json['banner_list'] != null) {
      bannerList = new List<BannerList>();
      json['banner_list'].forEach((v) {
        bannerList.add(new BannerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.typeList != null) {
      data['type_list'] = this.typeList.map((v) => v.toJson()).toList();
    }
    if (this.bannerList != null) {
      data['banner_list'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TypeList {
  int id;
  String title;
  int dataFlag;
  int sorts;
  List<Lists> lists;

  TypeList({this.id, this.title, this.dataFlag, this.sorts, this.lists});

  TypeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dataFlag = json['dataFlag'];
    sorts = json['sorts'];
    if (json['lists'] != null) {
      lists = new List<Lists>();
      json['lists'].forEach((v) {
        lists.add(new Lists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['dataFlag'] = this.dataFlag;
    data['sorts'] = this.sorts;
    if (this.lists != null) {
      data['lists'] = this.lists.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lists {
  int id;
  String title;
  String image;
  Null descs;

  Lists({this.id, this.title, this.image, this.descs});

  Lists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    descs = json['descs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['descs'] = this.descs;
    return data;
  }
}

class BannerList {
  int id;
  String img;
  String name;
  String url;
  int advType;
  int artId;
  Null pcRoute;
  Null mRoute;
  Null route;

  BannerList(
      {this.id,
        this.img,
        this.name,
        this.url,
        this.advType,
        this.artId,
        this.pcRoute,
        this.mRoute,
        this.route});

  BannerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    url = json['url'];
    advType = json['adv_type'];
    artId = json['art_id'];
    pcRoute = json['pc_route'];
    mRoute = json['m_route'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['url'] = this.url;
    data['adv_type'] = this.advType;
    data['art_id'] = this.artId;
    data['pc_route'] = this.pcRoute;
    data['m_route'] = this.mRoute;
    data['route'] = this.route;
    return data;
  }
}