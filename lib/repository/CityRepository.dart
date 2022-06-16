import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:try_startup/_common/firebase/WithDocId.dart';
import 'package:try_startup/_common/firebase/firestore/FirebaseRepository.dart';
import 'package:try_startup/extension/NullableExtension.dart';

import '../_common/model/exception/CommonException.dart';

class CityRepository extends FirebaseRepository<City> {
  static final CityRepository me = CityRepository._internal();

  CityRepository._internal()
      : super(
          collectionName: "City",
          fromFirestore: City.fromFirestore,
          toFirestore: (City city, options) => city.toFirestore(),
        );
}

class City extends WithDocId {
  final String? name;
  final String? state;
  final String? country;
  final bool? capital;
  final int? population;
  final List<String>? regions;

  City({
    this.name,
    this.state,
    this.country,
    this.capital,
    this.population,
    this.regions,
  });

  factory City.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return City(
      name: data?['name'],
      state: data?['state'],
      country: data?['country'],
      capital: data?['capital'],
      population: data?['population'],
      regions:
          data?['regions'] is Iterable ? List.from(data?['regions']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (capital != null) "capital": capital,
      if (population != null) "population": population,
      if (regions != null) "regions": regions,
    };
  }

  void throwInputError() {
    if(name.isNullOrEmpty) throw CommonException(message: "도시 이름 항목이 비어있습니다.");
    if(state.isNullOrEmpty) throw CommonException(message: "상태 항목이 비어있습니다.");
    if(country.isNullOrEmpty) throw CommonException(message: "나라 이름 항목이 비어있습니다.");
  }
}
