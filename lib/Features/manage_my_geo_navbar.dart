import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import '../widgets/customscfaffold_widget.dart';

class ManageMyGeo extends StatefulWidget {
  const ManageMyGeo({super.key});

  @override
  State<ManageMyGeo> createState() => _ManageMyGeoState();
}

class _ManageMyGeoState extends State<ManageMyGeo> {
  List<Map<String, dynamic>> folders = [
    {'label': 'Saved Previous Searches', 'value': true},
    {'label': 'Saved Resources', 'value': false},
    {'label': 'Saved Uploaded Resources', 'value': false},
    {'label': 'My Contacts', 'value': false},
  ];

  int folderCounter = 1;

  bool calendar = true;
  bool notifications = false;
  bool systemAlerts = false;
  bool events = false;

  bool video = true;
  bool blogs = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isDrawerRequired: false,
      appbartitle: 'Manage My Geo',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Folders (Icons)',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    // Render dynamic folder list
                    ...folders.asMap().entries.map((entry) {
                      int index = entry.key;
                      var folder = entry.value;
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(folder['label']),
                        value: folder['value'],
                        activeColor: const Color(0xFF4B6FFF),
                        onChanged: (val) {
                          setState(() {
                            folders[index]['value'] = val ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }).toList(),

                    const SizedBox(height: 10),
                    SizedBox(
                      height: 32,
                      child: TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF4B6FFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            minimumSize: const Size(70, 32),
                          ),
                          icon: const Icon(Icons.add,
                              color: Colors.white, size: 20),
                          label: const Text(
                            'Add',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController folderNameController =
                                    TextEditingController();

                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  title: Text('Add New Folder',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'Satoshi',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800)),
                                  content: SizedBox(
                                    height: 60,
                                    child: TextField(
                                      controller: folderNameController,
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter folder name',
                                        hintStyle: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'Satoshi',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        'Add',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'Satoshi',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      onPressed: () {
                                        String folderName =
                                            folderNameController.text.trim();
                                        if (folderName.isNotEmpty) {
                                          setState(() {
                                            folders.add({
                                              'label': folderName,
                                              'value': false
                                            });
                                          });
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),

                                    /* ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF4B6FFF),
                                      ),
                                      child: const Text('Add'),
                                      onPressed: () {
                                        String folderName =
                                            folderNameController.text.trim();
                                        if (folderName.isNotEmpty) {
                                          setState(() {
                                            folders.add({
                                              'label': folderName,
                                              'value': false
                                            });
                                          });
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),*/
                                  ],
                                );
                              },
                            );
                          }

                          //  onPressed: () {
                          // setState(() {
                          //   folders.add({
                          //     'label': 'New Folder ${folderCounter++}',
                          //     'value': false,
                          //   });
                          // });
                          // },
                          ),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'Then Drag (+Drop) to Position',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Calendar'),
                      value: calendar,
                      activeColor: const Color(0xFF4B6FFF),
                      onChanged: (val) {
                        setState(() {
                          calendar = val ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Notifications'),
                      value: notifications,
                      activeColor: const Color(0xFF4B6FFF),
                      onChanged: (val) {
                        setState(() {
                          notifications = val ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('System Alerts'),
                      value: systemAlerts,
                      activeColor: const Color(0xFF4B6FFF),
                      onChanged: (val) {
                        setState(() {
                          systemAlerts = val ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Events'),
                      value: events,
                      activeColor: const Color(0xFF4B6FFF),
                      onChanged: (val) {
                        setState(() {
                          events = val ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Upload To',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Video'),
                      value: video,
                      activeColor: const Color(0xFF4B6FFF),
                      onChanged: (val) {
                        setState(() {
                          video = val ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Blogs'),
                      value: blogs,
                      activeColor: const Color(0xFF4B6FFF),
                      onChanged: (val) {
                        setState(() {
                          blogs = val ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 342,
              height: 60,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants().themeColor,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Update',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Satoshi',
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/update_check.png',
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class ManageMyGeo extends StatefulWidget {
//   const ManageMyGeo({Key? key}) : super(key: key);

//   @override
//   State<ManageMyGeo> createState() => _ManageMyGeoState();
// }

// class _ManageMyGeoState extends State<ManageMyGeo> {
//   // Checkbox states
//   bool savedPreviousSearches = true;
//   bool savedResources = false;
//   bool savedUploadedResources = false;
//   bool myContacts = false;

//   bool calendar = true;
//   bool notifications = false;
//   bool systemAlerts = false;
//   bool events = false;

//   bool video = true;
//   bool blogs = false;

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffoldWidget(
//       isDrawerRequired: true,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.85,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Select Folders (Icons)',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 8),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('Saved Previous Searches'),
//                       value: savedPreviousSearches,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           savedPreviousSearches = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('Saved Resources'),
//                       value: savedResources,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           savedResources = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('Saved Uploaded Resources'),
//                       value: savedUploadedResources,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           savedUploadedResources = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('My Contacts'),
//                       value: myContacts,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           myContacts = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 32,
//                       child: TextButton.icon(
//                         style: TextButton.styleFrom(
//                           backgroundColor: const Color(0xFF4B6FFF),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 0),
//                           minimumSize: Size(70, 32),
//                         ),
//                         icon: const Icon(Icons.add,
//                             color: Colors.white, size: 20),
//                         label: const Text(
//                           'Add',
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.w500),
//                         ),
//                         onPressed: () {},
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'Then Drag (+Drop) to Position',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 8),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('Calendar'),
//                       value: calendar,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           calendar = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('Notifications'),
//                       value: notifications,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           notifications = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('System Alerts'),
//                       value: systemAlerts,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           systemAlerts = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('Events'),
//                       value: events,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           events = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'Upload To',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 8),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('Video'),
//                       value: video,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           video = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                     CheckboxListTile(
//                       contentPadding: EdgeInsets.zero,
//                       title: const Text('Blogs'),
//                       value: blogs,
//                       activeColor: const Color(0xFF4B6FFF),
//                       onChanged: (val) {
//                         setState(() {
//                           blogs = val ?? false;
//                         });
//                       },
//                       controlAffinity: ListTileControlAffinity.leading,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       appbartitle: 'Manage My Geo',
//     );
//   }
// }
