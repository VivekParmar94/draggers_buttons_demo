import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DockScreen(),
    );
  }
}

class DockScreen extends StatefulWidget {
  @override
  _DockScreenState createState() => _DockScreenState();
}

class _DockScreenState extends State<DockScreen> {
  Random random = Random();
  List<IconData> dockIcons = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  List<Color> colorList = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
    Colors.pink,
  ];

  List<IconData> draggedIcons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Text(
              'Drag icons out of the dock!',
              style: TextStyle(color: Colors.blueGrey, fontSize: 24),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(minWidth: 48),
                height: 68,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: dockIcons.map((icon) {
                    return DraggableIcon(
                      iconData: icon,
                      color: Color.fromARGB(
                        255,
                        random.nextInt(256), // Red
                        random.nextInt(256), // Green
                        random.nextInt(256), // Blue
                      ),
                      onDragCompleted: () {
                        setState(() {
                          draggedIcons.add(icon);
                          dockIcons.remove(icon);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          ...draggedIcons.map((icon) {
            return Positioned(
              top: 100,
              left: 50,
              child: Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class DraggableIcon extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onDragCompleted;
  final Color color;

  DraggableIcon(
      {required this.iconData,
      required this.onDragCompleted,
      required this.color});

  @override
  _DraggableIconState createState() => _DraggableIconState();
}

class _DraggableIconState extends State<DraggableIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      child: Draggable<IconData>(
        data: widget.iconData,
        feedback: Icon(
          widget.iconData,
          size: 50,
          color: widget.color,
        ),
        childWhenDragging: SizedBox.shrink(),
        onDragCompleted: widget.onDragCompleted,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
          child: Icon(
            widget.iconData,
            size: 40,
            color: widget.color,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
