import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:developerz/utils/Credentials.dart';
import 'package:developerz/utils/imagePicker.dart';
import 'package:flutter/cupertino.dart';

class UtilityNotifier extends ChangeNotifier {
  final ImageUtility imageUtility = ImageUtility();

  String userimage = "";
  String get getuserimage => userimage;

  Future uploadImage() async {
    final cloudinary = Cloudinary(Cred.APIKEY, Cred.APISecret, Cred.Cloud);
    try {
      final image = await ImageUtility.getImage();

      await cloudinary
          .uploadFile(
              filePath: image!.path, resourceType: CloudinaryResourceType.image)
          .then((value) {
        userimage = value.secureUrl!;
        notifyListeners();
        return userimage;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void setUserImageVoid() {
    userimage = "";
    notifyListeners();
  }
}
