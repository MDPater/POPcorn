import 'package:popcorn/screens/people/model/people_credit_model.dart';
import 'package:popcorn/screens/people/model/people_model.dart';

class PeopleController {
  Future<PeopleModel> getPeopleData(int id) async {
    return await PeopleModel.fetchPeopleData(id);
  }

  Future<PeopleCreditModel> getPeopleCredit(int id) async {
    return await PeopleCreditModel.fetchPeopleCredit(id);
  }
}
