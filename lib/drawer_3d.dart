import 'package:flutter/material.dart';
import 'dart:math' show pi;

class Drawer3D extends StatefulWidget {
  const Drawer3D({super.key});

  @override
  State<Drawer3D> createState() => _Drawer3DState();
}

class _Drawer3DState extends State<Drawer3D> with TickerProviderStateMixin {
  late AnimationController _drawerController;
  late AnimationController _homeController;
  late Animation _drawerAnimation;
  late Animation _homeAnimation;
  final Duration toggleDuration=Duration(milliseconds: 500);

  @override
  void initState() {
    _drawerController=AnimationController(vsync: this,duration:toggleDuration);
    _homeController=AnimationController(vsync: this,duration: toggleDuration);
    _homeAnimation=Tween<double>(begin: 0,end: -pi/2.4).animate(_homeController);
    _drawerAnimation=Tween<double>(begin: pi/2.7,end: 0).animate(_homeController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth= MediaQuery.of(context).size.width;
    final maxDrag=screenWidth*0.8;

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details){
        final delta=details.delta.dx/maxDrag;
        _drawerController.value+=delta;
        _homeController.value+=delta;

      },
      onHorizontalDragEnd: (DragEndDetails details){
        if(_drawerController.value<0.5){
          _drawerController.reverse();
          _homeController.reverse();
        }
        else{
          _drawerController.forward();
          _homeController.forward();
        }

      },

      child: AnimatedBuilder(
        animation: Listenable.merge([
          _homeAnimation,_drawerAnimation
        ]),
        builder: (BuildContext context, Widget? child) {
          return Stack(
            //fit: StackFit.expand,
            children: [
              Container(
                color: const Color(0xFF1a1b26),
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(-screenWidth+_drawerController.value*maxDrag)
                  ..rotateY(_drawerAnimation.value)
                ,
                child: Material(
                  child: Container(
                    color: Colors.blueGrey,
                    width: screenWidth,
                    child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Text('Item 1'),
                        Text('Item 1'),
                        Text('Item 1'),
                        Text('Item 1'),
                      ],
                    ),
                  ),
                ),
              ),

              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()..setEntry(3, 2, 0.001)
                  ..translate(maxDrag*_homeController.value)
                  ..rotateY(_homeAnimation.value),
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('child'),
                  ),
                  body: Container(),
                ),
              )
            ],
          );
        },

      ),
    );
  }
}
