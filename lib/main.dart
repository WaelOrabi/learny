
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learny_project/features/auth/data/models/user_model.dart';
import 'package:learny_project/features/home/presentation/pages/home_page_admin.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/my_App_Theme.dart';
import 'features/content/presentation/pages/posts/add_posts.dart';
import 'features/content/presentation/pages/posts/posts_page.dart';
import 'features/content/presentation/pages/questions/questions.dart';
import 'injection_container.dart' as di;
import 'features/auth/data/datasources/local_data_sources/auth_local_data_sources.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'core/error/exception.dart';
import 'core/list_of_bloc_providers.dart';


void main() async {
  await di.init();
  UserModel? userModel=await   loadUser();
  WidgetsFlutterBinding.ensureInitialized();


  runApp( MyApp(userModel: userModel,));

}

class MyApp extends StatelessWidget {
final UserModel?userModel;
  const MyApp({super.key,this.userModel});

  @override
  Widget build(BuildContext context) {
  Widget _screen=Container();
  bool isAdmin=false;
 if(userModel!= null){
   userModel!.roles!.map((e){
     if(e.name=="owner" || e.name=="admin"){
       isAdmin=true;
     }
   }).toList();
 }
 if(isAdmin){
   _screen=HomePageAdmin();
 }else{
   _screen=HomePage(userModel: userModel,);
 }
    return  ScreenUtilInit(
        designSize: const Size(1440, 1024),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child){
     return MultiBlocProvider(
        providers: createBlocProviders(),
        child: MaterialApp(
          theme: MyAppTheme.myTheme,
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          home:_screen,

        ),
      );

    });
  }

}

Future<UserModel?> loadUser() async {
  final AuthLocalDataSources authLocalDataSourcesImpl =
  di.sl<AuthLocalDataSources>();
  try {
    final value = await authLocalDataSourcesImpl.getCachedUser();
    return value;
  } catch (error) {
    if (error is EmptyCacheException) {
     return null;
    }
  }
  return null;
}


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
