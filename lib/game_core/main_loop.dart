import 'dart:isolate';

bool _mainRunning = true;

void mainLoop(SendPort sendPort) async {
  const double _fps = 50;
  const double _second = 1000;
  const double _updateTime = _second / _fps;

  //таймер-счетчик
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  while (_mainRunning) {
    if (_loopWatch.elapsedMilliseconds >= _updateTime) {
      _loopWatch.reset();
      sendPort.send(true); //отправляем другим изолятам тру
    }
  }
}

void stopMainLoop() {
  _mainRunning = false;
}