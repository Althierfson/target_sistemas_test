import 'package:target_sistemas_test/data/models/user_model.dart';
import 'package:target_sistemas_test/domain/entities/user.dart';

UserModel Function() getUserModel = () => const UserModel(
    id: 15,
    username: "kminchelle",
    email: "kminchelle@qq.com",
    firstName: "Jeanne",
    lastName: "Halvorson",
    gender: "female",
    image: "https://robohash.org/autquiaut.png?size=50x50&set=set1",
    token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.FAKE");

User Function() getUserEntity = () => const User(
    id: 15,
    username: "kminchelle",
    email: "kminchelle@qq.com",
    firstName: "Jeanne",
    lastName: "Halvorson",
    gender: "female",
    image: "https://robohash.org/autquiaut.png?size=50x50&set=set1",
    token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.FAKE");
