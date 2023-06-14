import 'package:dzero/controllers/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final launcherProvider = FutureProvider.family<void, String>((ref, url) async {
  return await Launcher.abrirEnlace(url);
});
