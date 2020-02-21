class ShopAddressListEntity {
	String msg;
	int code;
	ShopAddressListInfo info;

	ShopAddressListEntity({this.msg, this.code, this.info});

	ShopAddressListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new ShopAddressListInfo.fromJson(json['info']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.info != null) {
      data['info'] = this.info.toJson();
    }
		return data;
	}
}

	class ShopAddressListInfo {
	List<ShopAddressListInfoList> lists;

	ShopAddressListInfo({this.lists});

	ShopAddressListInfo.fromJson(Map<String, dynamic> json) {
		if (json['lists'] != null) {
			lists = new List<ShopAddressListInfoList>();(json['lists'] as List).forEach((v) { lists.add(new ShopAddressListInfoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.lists != null) {
      data['lists'] =  this.lists.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ShopAddressListInfoList {
	String area;
	String address;
	int proId;
	String city;
	String name;
	String tel;
	int id;
	int areaId;
	String pro;
	int isDef;
	int cityId;

	ShopAddressListInfoList({this.area, this.address, this.proId, this.city, this.name, this.tel, this.id, this.areaId, this.pro, this.isDef, this.cityId});

	ShopAddressListInfoList.fromJson(Map<String, dynamic> json) {
		area = json['area'];
		address = json['address'];
		proId = json['pro_id'];
		city = json['city'];
		name = json['name'];
		tel = json['tel'];
		id = json['id'];
		areaId = json['area_id'];
		pro = json['pro'];
		isDef = json['is_def'];
		cityId = json['city_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['area'] = this.area;
		data['address'] = this.address;
		data['pro_id'] = this.proId;
		data['city'] = this.city;
		data['name'] = this.name;
		data['tel'] = this.tel;
		data['id'] = this.id;
		data['area_id'] = this.areaId;
		data['pro'] = this.pro;
		data['is_def'] = this.isDef;
		data['city_id'] = this.cityId;
		return data;
	}
}
