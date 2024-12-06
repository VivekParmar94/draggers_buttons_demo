import 'package:flutter/material.dart';



class DraggableIcons extends StatefulWidget {
  @override
  _DraggableIconsState createState() =>
      _DraggableIconsState();
}

class _DraggableIconsState
    extends State<DraggableIcons> {
  // List of icons
  List<IconData> dockIcons = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  // Corresponding colors for each icon
  List<Color> dockColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple], // Gradient colors
            begin: Alignment.topLeft, // Gradient start point
            end: Alignment.bottomRight, // Gradient end point
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child:
          Container(
            margin: EdgeInsets.only(left: 6.0, right: 6.0,bottom: 6.0), // Margin on left and right
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue, // Background color
              borderRadius: BorderRadius.circular(15), // Rounded corners
              border: Border.all(
                color: Colors.grey, // Border color
                width: 1, // Border width
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 5, // How far the shadow spreads
                  blurRadius: 10, // Softness of the shadow
                  offset: Offset(4, 4), // Shadow position (x, y)
                ),
              ],
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.white], // Gradient colors
                begin: Alignment.topLeft, // Gradient start point
                end: Alignment.bottomRight, // Gradient end point
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: dockIcons.asMap().entries.map((entry) {
                final index = entry.key;
                final icon = entry.value;

                return DragTarget<int>(
                  onAccept: (fromIndex) {
                    setState(() {
                      // Swap icons
                      final tempIcon = dockIcons[fromIndex];
                      final tempColor = dockColors[fromIndex];

                      dockIcons[fromIndex] = dockIcons[index];
                      dockColors[fromIndex] = dockColors[index];

                      dockIcons[index] = tempIcon;
                      dockColors[index] = tempColor;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Draggable<int>(
                      data: index,
                      feedback: Material(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child:Container(
                          padding: EdgeInsets.all(10),
                          color: dockColors[index],
                          child: Icon(icon, size: 40, color: Colors.white),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: dockColors[index],
                          child: Icon(icon, size: 40, color: Colors.white),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Container(
                          padding: EdgeInsets.all(10),
                          color: dockColors[index],
                          child: Icon(icon, size: 40, color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
