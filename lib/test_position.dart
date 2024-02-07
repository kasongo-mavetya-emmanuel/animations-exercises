
import 'package:flutter/material.dart';

class TestPosition extends StatefulWidget {
  const TestPosition({super.key});

  @override
  State<TestPosition> createState() => _TestPositionState();
}

class _TestPositionState extends State<TestPosition> with SingleTickerProviderStateMixin{

  AnimationController? _controller;
  Animation? animation;

  @override
  void initState() {
   _controller=
       AnimationController(vsync: this,duration: Duration(milliseconds: 250));
   animation= Tween(begin: 0.0,end: 1.0,).animate(CurvedAnimation(
       parent: _controller!, curve: Curves.linear));

   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double transx= MediaQuery.of(context).size.width*0.7;

    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details){
        print('eee${details.globalPosition.dx} ${transx}');
        final delta=details.delta.dx/transx;
        _controller!.value+=delta;

      },
      onHorizontalDragEnd: (DragEndDetails details){
       if(animation!.value<0.5){
         _controller!.reverse();
       }
       else{
         _controller!.forward();
       }

      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                SizedBox(height: 50,),
                IconButton(
                  onPressed: () {
                    if(animation!.status==AnimationStatus.completed){
                      _controller!.reverse();

                    }
                    else{
                      _controller!.forward();
                    }
                  },
                  icon: Icon(Icons.menu),),
                Text('Item 1'),
                Text('Item 1'),
                Text('Item 1'),
                Text('Item 1'),
                Text('Item 1')
              ],
            ),
          ),

          AnimatedBuilder(
            animation: animation!,
            builder: (BuildContext context, Widget? child) {
              print('${_controller?.value}');


              return Transform(
                transform: Matrix4.identity()..translate(transx*animation!.value,animation!.value*100)
                  ..scale(1-animation!.value*0.3),
                child: Container(
                  color: Colors.yellow,
                  width: double.infinity,
                  height: double.infinity,
                  child:  IconButton(
                    onPressed: () {
                      if(animation!.status==AnimationStatus.completed){
                        _controller!.reverse();
                      }
                      else{
                        _controller!.forward();
                      }
                    },
                    icon: Icon(Icons.menu),),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _onHorizontalDragStart(details){
    // print('ddd${details}');

  }
  _onHorizontalDragUpdate(DragUpdateDetails details){
    print('eee${details.delta}');
  }
  _onHorizontalDragEnd(details){

  }
}
