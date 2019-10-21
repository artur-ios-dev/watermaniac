import 'package:flutter/material.dart';

class RadialMenuController extends ChangeNotifier {
   final AnimationController _progress;
   RadialMenuState _state = RadialMenuState.open;
   String _activationId;

   RadialMenuController({
     @required TickerProvider vsync,
   }) : _progress = AnimationController(vsync: vsync) {
     _progress
       ..addListener(_onProgressUpdate)
       ..addStatusListener((AnimationStatus status) {
         if (status == AnimationStatus.completed) {
           _onTransitionCompleted();
         }
       });
   }

   void _onProgressUpdate() {
     notifyListeners();
   }

   void _onTransitionCompleted() {
     switch (_state) {
       case RadialMenuState.expanding:
         _state = RadialMenuState.expanded;
         break;
       case RadialMenuState.collapsing:
         _state = RadialMenuState.open;
         break;
       case RadialMenuState.open:
       case RadialMenuState.expanded:
         throw Exception('Invalid state during a transition: $_state');
         break;
     }

     notifyListeners();
   }

   RadialMenuState get state => _state;

   double get progress => _progress.value;

   String get activationId => _activationId;

   void expand() {
     if (state == RadialMenuState.open) {
       _state = RadialMenuState.expanding;
       _progress.duration = Duration(milliseconds: 150);
       _progress.forward(from: 0.0);
       notifyListeners();
     }
   }

   void collapse() {
     if (state == RadialMenuState.expanded) {
       _state = RadialMenuState.collapsing;
       _progress.duration = Duration(milliseconds: 150);
       _progress.forward(from: 0.0);
       notifyListeners();
     }
   }
 }

 enum RadialMenuState {
   open,
   expanding,
   collapsing,
   expanded,
 }
