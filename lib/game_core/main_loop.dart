import 'dart:isolate';

bool running = true;

void mainLoop(SendPort sendPort) async {
  const double _fps = 40;
  const double _second = 1000;
  const double _updateTime = _second / _fps;

  //таймер-счетчик
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  while (running) {
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

  while (running) {
    if (_loopWatch.elapsedMilliseconds >= _updateTime) {
      _loopWatch.reset();
      sendPort.send(true);
    }
  }
}

void meteorLoop(SendPort sendPort) async {
  const double _updateTime = 1500;

  //таймер-счетчик
  Stopwatch _loopWatch = Stopwatch();
  _loopWatch.start();

  while (running) {
    if (_loopWatch.elapsedMilliseconds >= _updateTime) {
      _loopWatch.reset();
      sendPort.send(true);
    }
  }
}

void stopLoop() {
  running = false;
}