import 'package:flutter/material.dart';
import 'package:readytogo/Features/Resources/reading_material_screen.dart';
import 'package:readytogo/widgets/customscfaffold_widget.dart';
import '../../widgets/boxDecorationWidget.dart';

class ResourcesScreen extends StatefulWidget {
  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final List<_ResourceItem> items = [
    _ResourceItem('Reading Materials', 'assets/phone.png'),
    _ResourceItem('Courses', 'assets/Character.png'),
    _ResourceItem('Education', 'assets/education.png'),
    _ResourceItem('Youtube', 'assets/Comment.png'),
    _ResourceItem('Self Uploaded', 'assets/selfuploaded.png'),
  ];

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isDrawerRequired: true,
      appbartitle: 'Rescources',
      body: DecoratedBox(
        decoration: boxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 140,
                      width: 376,
                      child: _ResourceCard(
                        item: items[index],
                        onTap: () {
                          if (items[index].title == "Reading Materials") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReadingMaterialsScreen()));
                          }
                          print("Click ${items[index].title}");
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResourceItem {
  final String title;
  final String imagePath;

  _ResourceItem(this.title, this.imagePath);
}

class _ResourceCard extends StatelessWidget {
  final _ResourceItem item;
  Function onTap;

  _ResourceCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Image.asset(item.imagePath, width: 90, height: 130),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 0),
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing.',
                        style: TextStyle(
                          color: Color(0XFF323747),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Icon(Icons.open_in_new_rounded,
                    color: Color(0xFF4A60A1),
                    size: 20), //Image.asset("assets/arrow-up-right.png")
              )
            ],
          ),
        ),
      ),
    );
  }
}
