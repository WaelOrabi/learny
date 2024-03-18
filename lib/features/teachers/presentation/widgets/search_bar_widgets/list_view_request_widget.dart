import 'package:flutter/material.dart';
class ListViewRequestWidget extends StatelessWidget {
  const ListViewRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder:(context,index){
      return ConstrainedBox(constraints:BoxConstraints(
        maxHeight: 400,
        maxWidth: 200,
      ),
      child: Column(
          children: [
            CircleAvatar(
              foregroundImage: AssetImage(
                'assets/images/profile.png',
              ),
              radius: 50,
            ),
            SizedBox(height: 20,)
        ],
      ),
      );
    });
  }
}
