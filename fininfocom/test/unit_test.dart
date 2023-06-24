import 'package:fininfocom/repo/repo.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

void main() {
  group("API Testing", () {
    test("Check for Random Image", () async {
      final image1 = await AppRepo.fetchImage();
      final image2 = await AppRepo.fetchImage();
      expect(image1, isNot(image2));
    });

    test("Check for randomuser API & Parsing API", () async {
      final profile = await AppRepo.getProfileData();
      expect(profile.results?.length ?? 0, greaterThan(0));
    });
  });
}
