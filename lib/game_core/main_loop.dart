import 'dart:isolate';

bool _running = true;

void mainLoop(SendPort sendPort) async {
  const double _fps = 50;
  const double _second = 1000;
  const double _updateTime = _second / _fps;

  //таймер-счетчик
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  while (_running) {
    if (_loopWatch.elapsedMilliseconds >= _updateTime) {
      _loopWatch.reset();
      sendPort.send(true); //отправляем другим изолятам тру
    }
  }
}

void shotLoop(SendPort sendPort) async {
  const double _updateTime = 500; //0.5секунд

  //таймер-счетчик
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  while (_running) {
    if (_loopWatch.elapsedMilliseconds >= _updateTime) {
      _loopWatch.reset();
      sendPort.send(true);
    }
  }
}

void meteorLoop(SendPort sendPort) async {
  const double _updateTime = 1000;

  //таймер-счетчик
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  while (_running) {
    if (_loopWatch.elapsedMilliseconds >= _updateTime) {
      _loopWatch.reset();
      sendPort.send(true);
    }
  }
}

void stopLoop() {
  _running = false;
}