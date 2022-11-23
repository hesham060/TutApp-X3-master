// OnBoarding models
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

//login models
// should be non non nullabe because not receving empty data
class Customers {
  String id;
  String name;
  int numOfNotifications;
  Customers(this.id, this.name, this.numOfNotifications);
}
class Contacts {
  String phone;
  String email;
  String link;
  Contacts(this.phone, this.email, this.link);
}
class Authentication{
  Customers? customer;
  Contacts? email;
  Authentication(this.customer,this.email);


  
}

