import 'package:bloc/bloc.dart';

class TrackState extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.state} $change');
  }
}
