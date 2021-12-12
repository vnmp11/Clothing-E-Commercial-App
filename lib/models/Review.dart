import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String image;
  String name;
  double rating;
  String date;
  String comment;

  ReviewModel({ required this.image, required this.name, required this.rating, required this.date, required this.comment});

  // ReviewModel().fromSnapshot(DocumentSnapshot snapshot) {
  //   image = snapshot['image'];
  //   name = snapshot['name'];
  //   rating = snapshot['rating'];
  //   date = snapshot['date'];
  //   comment = snapshot['comment'];
  // }

  Map<String, dynamic> toMap() {
    return {
      'image': this.image,
      'name': this.name,
      'rating': this.rating,
      'date': this.date,
      'comment': this.comment,
    };
  }
}
List<ReviewModel> reviewList = [
    ReviewModel(
      image: "assets/images/mensFashion.jpg",
      name: "John Travolta",
      rating: 3.5,
      date: "01 Jan 2021",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/girlsFashion.jpg",
      name: "Scarlett Johansson",
      rating: 2.5,
      date: "21 Feb 2021",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user1.jpg",
      name: "Jennifer Lawrence",
      rating: 4.5,
      date: "17 Mar 2021",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user11.jpg",
      name: "Michael Jordan",
      rating: 1.5,
      date: "12 Apr 2021",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    ReviewModel(
      image: "assets/images/user2.jpg",
      name: "Nicole Kidman",
      rating: 2.0,
      date: "28 May 2021",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user10.jpg",
      name: "James Franco",
      rating: 4.0,
      date: "14 Nov 2020",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user3.jpg",
      name: "Margot Robbie",
      rating: 1.0,
      date: "14 Nov 2020",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user9.jpg",
      name: "Nicolas Cage",
      rating: 3.0,
      date: "14 Nov 2020",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user4.jpg",
      name: "Emma Stone",
      rating: 5.0,
      date: "14 Nov 2020",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user8.jpg",
      name: "Johnny Depp",
      rating: 3.5,
      date: "14 Nov 2020",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user5.jpg",
      name: "Natalie Portman",
      rating: 3.5,
      date: "14 Nov 2020",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user7.jpg",
      name: "Anne Hathaway",
      rating: 3.5,
      date: "14 Nov 2020",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModel(
      image: "assets/images/user6.jpg",
      name: "Charlize Theron",
      rating: 3.5,
      date: "14 Nov 2020",
      comment:
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
  ];

