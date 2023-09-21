import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/response/status.dart';
import 'package:flutter_application_1/utils/routes/routes_name.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/view_model/home_view_model.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    // HomeViewModel homeViewModel = HomeViewModel();
    // homeViewModel.getUserListfunc();

    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.getUserListfunc();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.logout),
          onPressed: () {
            userViewModel.RemoveUser().then((value) {
              Navigator.pushReplacementNamed(context, RouteName.loginscreen);
            }).onError((error, stackTrace) {
              Utils.flushBarErrorMessage(error.toString(), context);
            });
          }),
      body: Consumer<HomeViewModel>(
        builder: (context, value, _) {
          // if (kDebugMode) {
          //   print(value.userlist.status.toString()+'in Screen');
          // }

          switch (value.userlist.status) {
            case Status.ERROR:
              return const Center(
                child: Text("Status Error"),
              );
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.COMPLECTED:
              return ListView.builder(
                  itemCount: value.userlist.data!.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                          value.userlist.data!.data![index].avatar.toString()),
                      title: Text(value.userlist.data!.data![index].firstName
                          .toString()),
                      subtitle: Text(value.userlist.data!.data![index].lastName
                          .toString()),
                      isThreeLine: true,
                      trailing: Text(
                          value.userlist.data!.data![index].email.toString()),
                    );
                  });
            default:
              Utils.flushBarErrorMessage("Couldn,t load data", context);
          }
          return Container();
        },
      ),
    );
  }
}
