import 'package:bgcsphere/Messenger/Helper/date_util.dart';
import 'package:bgcsphere/Messenger/Screens%20Page/chat_screen.dart';
import 'package:bgcsphere/Messenger/api/apis.dart';
import 'package:bgcsphere/Messenger/model/message.dart';
import 'package:bgcsphere/Messenger/model/user_chat.dart';
import 'package:bgcsphere/Messenger/widgets/profile_dialouge.dart';
import 'package:bgcsphere/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserChatCart extends StatefulWidget {
  final ChatUser user;
  final ChatUser? userss;
  const UserChatCart({
    super.key,
    required this.user,
    this.userss,
  });

  @override
  State<UserChatCart> createState() => _UserChatCartState();
}

class _UserChatCartState extends State<UserChatCart> {
  Message? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.blue.shade100,
      elevation: 0.5,
      child: InkWell(
          onTap: () {
            //for chat screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
              stream: Apis.getLastMessages(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;

                final list =
                    data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

                if (list.isNotEmpty) _message = list[0];

                return ListTile(
                  leading: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => ProfileDialouge(user: widget.user));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .3),
                      child: CachedNetworkImage(
                        width: mq.height * .055,
                        height: mq.height * .055,
                        imageUrl: widget.user.image,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                                child: Icon(CupertinoIcons.person)),
                      ),
                    ),
                  ),
                  title: Text(widget.user.name),
                  subtitle: Text(
                    _message != null
                        ? _message!.type == Type.image
                            ? 'photo'
                            : _message!.msg
                        : widget.user.about,
                    maxLines: 1,
                  ),
                  trailing: _message == null
                      ? null
                      //for showing nothis is send
                      : _message!.read.isEmpty &&
                              _message!.fromId != Apis.user.uid
                          ?
                          //for unread message
                          Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : Text(
                              MyDateUtil.getLastMessageTime(
                                  context: context, time: _message!.sent),
                              style: const TextStyle(color: Colors.black54),
                            ),
                );
              })),
    );
  }
}
