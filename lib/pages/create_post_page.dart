import 'package:bgcsphere/pages/assetpage.dart';
import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xffA2ACE0).withOpacity(0.13),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: Color(0xff212329),
          
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              
              height: 37,
              decoration: BoxDecoration(color:Color(0xFF768FCF) ,
              borderRadius: BorderRadius.circular(12),),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF768FCF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.white,fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage('images/profile.jpg'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tasnova Hassan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF6677CC),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xff6677CC).withOpacity(0.5)),
                            ),
                            child: const Row(
                              children: [
                              
                                Icon(Icons.group, size: 16,color: Color(0xff6677CC),),
                                SizedBox(width: 4),
                                Text('Friends',style: TextStyle(color: Color(0xff536471)),),
                                SizedBox(width: 4,),            
                                  Icon(Icons.arrow_drop_down, size: 16),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                            
                              borderRadius: BorderRadius.circular(12),
                             border: Border.all(color: Color(0xff6677CC).withOpacity(0.5)),
                            ),
                            child: const Row(
                              children: [
                             
                                SizedBox(width: 4),
                                Icon(Icons.add,color: Color(0xff6677CC),size: 16,),
                                Text('Album'),
                                 SizedBox(width: 4,),            
                                  Icon(Icons.arrow_drop_down, size: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'What is in your mind?',
                style: TextStyle(fontSize: 24,color: Color(0xff536471),fontWeight: FontWeight.w100),
              ),
            ),
          ),
          
          const SizedBox(height: 110),
          IconButton(
            icon: Icon(
              showOptions ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              size: 28,
              color: Colors.black45,
            ),
            onPressed: () {
              setState(() {
                showOptions = !showOptions;
              });
            },
          ),
          if (showOptions)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    children: const [
                      PostOptionItem(
                          icon: Icons.image_outlined, label: "Photo/ Video"),
                      Divider(color: Color(0xff6677CC), thickness: 0.3),
                      PostOptionItem(
                          icon: Icons.person_add_alt_1, label: "Tag People"),
                      Divider(color: Color(0xff6677CC), thickness: 0.3),
                      PostOptionItem(
                          icon: Icons.emoji_emotions_outlined,
                          label: "Feeling/Activity"),
                      Divider(color: Color(0xff6677CC), thickness: 0.3),
                      PostOptionItem(
                          icon: Icons.format_color_fill,
                          label: "Background Color"),
                      Divider(color: Color(0xff6677CC), thickness: 0.3),
                      PostOptionItem(
                          icon: Icons.camera_alt_outlined, label: "Camera"),
                      Divider(color: Color(0xff6677CC), thickness: 0.3),
                      PostOptionItem(
                          icon: Icons.location_on_outlined, label: "Check in"),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

