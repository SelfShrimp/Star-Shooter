import 'dart:isolate';

bool _running = true;

void mainLoop(SendPort sendPort) async {
  const double _fps = 40;
  const double _second = 1000;
  const double _updateTime = _second / _fps;

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