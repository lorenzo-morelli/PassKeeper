import 'package:flutter/material.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/views/home/settings_form.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({Key? key, required this.account, required this.index}) : super(key: key);
  final Account account;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        margin: EdgeInsets.only(bottom: 15),
        child: ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: account.color,
          ),
          title: Text(account.site,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          subtitle: Text(
              'Username: ${account.username}\nPassword: ${account.password}'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Icon(Icons.settings, color: Colors.black54),
                onTap: () => showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Constants.cornRad),
                        topRight: Radius.circular(Constants.cornRad),
                      ),
                    ),
                    isScrollControlled: true,
                    //backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return SettingsForm(index: index, account: account);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
