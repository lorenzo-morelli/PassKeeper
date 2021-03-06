import 'package:encrypt/encrypt.dart' as kay;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flut;
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:passkeeper/models/account.dart';
import 'package:passkeeper/services/encryption/encryption_contract.dart';
import 'package:passkeeper/services/encryption/encryption_service.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/shared/constants.dart';
import 'package:passkeeper/shared/tocolor_extension.dart';
import 'package:passkeeper/views/home/settings_form.dart';

class AccountTile extends StatefulWidget {
  const AccountTile({flut.Key? key, required this.account, required this.index}) : super(key: key);
  final Account account;
  final int index;


  @override
  _AccountTileState createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    IEncryption sut = EncryptionService(Encrypter(AES(kay.Key.fromLength(32))));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Card(
            shadowColor: widget.account.color.replaceAll('0xff', '0x0f').toColor(),
            color: widget.account.color.replaceAll('0xff', '0x1f').toColor(),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            margin: EdgeInsets.only(bottom: 15),
            child: ListTile(
              isThreeLine: widget.account.username.isNotEmpty ? true : false,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor: widget.account.color.toColor(),
                      ),
                      iconAvatar(context),
                    ],
                  ),
                ],
              ),
              title: Text(widget.account.site, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
              subtitle: Text(
                  widget.account.username.isNotEmpty
                      ? '${widget.account.username}\n'
                      'Password: ${obscure ? sut.decrypt(widget.account.password).replaceAll(RegExp(r"."), "*") : sut.decrypt(widget.account.password)}'
                      : 'Password: ${obscure ? sut.decrypt(widget.account.password).replaceAll(RegExp(r"."), "*") : sut.decrypt(widget.account.password)}',
                  style: TextStyle(fontSize: 15)),
              trailing: GestureDetector(
                child: obscure
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.solidEye, size: 19, color: Colors.grey[600]),
                  ],
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.solidEyeSlash, size: 19, color: Colors.grey[600]),
                  ],
                ),
                onTap: () => setState(() => obscure = !obscure),
              ),
            ),
          ),
          onLongPress: () {
            HapticFeedback.mediumImpact();
            showModalBottomSheet(
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
                  return SettingsForm(index: widget.index, account: widget.account);
                });
          }),
    );
  }

  Widget iconAvatar(BuildContext context) {
    for (int i = 0; i < Constants.sites.length; i++) {
      if (widget.account.site.toLowerCase().contains(Constants.sites[i])) {
        return Constants.icons[i];
      }
    }
    return SizedBox();
  }
}
