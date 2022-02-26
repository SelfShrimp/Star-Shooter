import 'dart:isolate';

bool _shotRunning = true;

void shotLoop(SendPort sendPort) async {
  const double _updateTime = 500; //0.5секунд

  //таймер-счетчик
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  while (_shotRunning) {
    if (_loopWatch.elapsedMilliseconds >= _updateTime) {
      _loopWatch.reset();
      sendPort.send(true);
    }
  }
}

void stopMainLoop() {
  _shotRunning = false;
}