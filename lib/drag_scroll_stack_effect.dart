import 'package:flutter/material.dart';

class DragScrollStackEffect extends StatefulWidget {
  const DragScrollStackEffect({super.key});

  @override
  State<DragScrollStackEffect> createState() => _DragScrollStackEffectState();
}

class _DragScrollStackEffectState extends State<DragScrollStackEffect> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller=AnimationController(vsync: this,
        duration: Duration(milliseconds: 250));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final scrHgt= MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          //fit: StackFit.expand,
          children: [
            Container(
              color: Colors.cyan,
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (DragUpdateDetails details){
                  final delta= details.delta.dy/scrHgt;
                  print('ffff${details.delta.dy} gggg${delta}');
                  _controller.value+=-delta;
                  print('jjjjjj${_controller.value}');
                },
                onVerticalDragEnd: (DragEndDetails details){
                  if(_controller.value<0.3){
                    _controller.reverse();
                  }else if(_controller.value>0.7){
                    _controller.forward();
                  }
                },
                child: AnimatedBuilder(
                    animation: _controller,
                    builder:(ctx, child){
                      return Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.grey,
                        height: scrHgt*0.15+(_controller.value*(scrHgt-(scrHgt*0.15))),
                        child: Stack(
                          children: [
                            // ListView.builder(
                            //   itemCount: 25,
                            //   itemBuilder: (BuildContext context, int index) {
                            //     return ListTile(title: Text('Item $index'));
                            //   },
                            // ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                color: Colors.blue,
                                height: 50+(50*_controller.value),
                                width: 50+(50*_controller.value),
                              ),),
                            AnimatedPositioned(
                              left: 60-(60*_controller.value),
                              top: 110*_controller.value,
                              duration: Duration(milliseconds: 10),
                              child: Container(
                                color: Colors.red,
                                height: 50+(50*_controller.value),
                                width: 50+(50*_controller.value),
                              ),),
                            Positioned(
                              left: 120-(120*_controller.value),
                              top: 220*_controller.value,
                              child: Container(
                                color: Colors.green,
                                height: 50+(50*_controller.value),
                                width: 50+(50*_controller.value),
                              ),),
                            Positioned(
                              left: 180-(180*_controller.value),
                              top: 330*_controller.value,
                              child: Container(
                                color: Colors.pinkAccent,
                                height: 50+(50*_controller.value),
                                width: 50+(50*_controller.value),
                              ),
                            ),
                          ],
                        ),
                      );


                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// onVerticalDragUpdate: (DragUpdateDetails details){
// final delta= details.delta.dy;
// _controller.value+=delta;
// },
// onVerticalDragEnd: (DragEndDetails details){
// if(_controller.value<0.3){
// _controller.reverse();
// }else if(_controller.value>0.7){
// _controller.forward();
// }
// },