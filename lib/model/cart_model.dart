class CartModel {
  String cartid;
  String cartname;
  String cartimage;
  String cartprice;
  String cartquantity;
  String storeid;
  String storeimage;
  CartModel({
    required this.cartid,
    required this.storeid,
    required this.storeimage,
    required this.cartimage,
    required this.cartname,
    required this.cartprice,
    required this.cartquantity,
  });
}

class Yourcartmodel {
  String paymentstatus;
  String storeid;
  String storeimage;
  Yourcartmodel({
    required this.storeid,
    required this.storeimage,
    required this.paymentstatus,
  });
}
