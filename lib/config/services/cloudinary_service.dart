import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dzero/config/constants/environment.dart';

final cloudinary = CloudinaryPublic(
  Environment.cloudName,
  Environment.uploadPreset,
  cache: true,
);
