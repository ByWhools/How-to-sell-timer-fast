import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

//Timer Provider extiende de ChangeNotifier y
// proporciona funcionalidades para un temporizador,
// con sonidos y efectos visuales.

class TimerProvider with ChangeNotifier {
  static const int initialMinutes = 2; // Valor inicial de minutos.
  static const int initialSeconds = 30; // Valor inicial de segundos.
  int minutes = initialMinutes; // Minutos actuales del temporizador.
  int seconds = initialSeconds; // Segundos actuales del temporizador.
  Timer? _timer; // Objeto `Timer` para el temporizador principal.
  Timer? _flashTimer; // Objeto `Timer` para el parpadeo de la pantalla.
  final AudioPlayer _audioPlayer = AudioPlayer(); // Reproductor de audio.
  bool isGameOver = false; // Indica si el juego ha terminado.
  bool isRunning = false; // Indica si el temporizador está en funcionamiento.
  Color screenColor = Colors.black; // Color de la pantalla.

  /// Inicia o pausa el temporizador.
  /// Si el temporizador está en funcionamiento, lo pausa.
  /// Si el temporizador no está en funcionamiento, lo inicia.
  void startTimer() {
    if (isRunning) {
      pauseTimer();
      return;
    }
    isRunning = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (seconds > 0) {
        seconds--;
      } else if (minutes > 0) {
        minutes--;
        seconds = 59;
      } else {
        isGameOver = true;
        await _playSound('game_over.mp3');
        resetTimer();
        return;
      }

      if (!isGameOver) {
        if (seconds == 0 && minutes > 0) {
          await _playSound('minute_sound.mp3');
          _flashScreen();
        } else {
          await _playSound('second_sound.mp3');
        }
      }

      notifyListeners();
    });
  }

  /// Pausa el temporizador si está en funcionamiento.

  void pauseTimer() {
    _timer?.cancel();
    isRunning = false;
    notifyListeners();
  }

  /// Reproduce un sonido dado el path del archivo de audio.

  Future<void> _playSound(String path) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path), volume: 0.5);
  }

  /// Parpadea la pantalla alternando colores entre negro y rojo.
  void _flashScreen() {
    int flashCount = 0;
    _flashTimer?.cancel();
    _flashTimer =
        Timer.periodic(const Duration(milliseconds: 100), (flashTimer) {
      screenColor = screenColor == Colors.black ? Colors.red : Colors.black;
      flashCount++;
      if (flashCount >= 5) {
        _flashTimer?.cancel();
        screenColor = Colors.red;
      }
      notifyListeners();
    });
  }

  /// Reinicia el temporizador a los valores iniciales.

  void resetTimer() {
    _timer?.cancel();
    _flashTimer?.cancel();
    minutes = initialMinutes;
    seconds = initialSeconds;
    isGameOver = false;
    isRunning = false;
    screenColor = Colors.black;
    notifyListeners();
  }

  /// Añade 10 segundos al temporizador.

  void addTenSeconds() {
    if (seconds <= 49) {
      seconds += 10;
    } else {
      if (minutes > 0) {
        minutes++;
        seconds = (seconds + 10) % 60;
      }
    }
    notifyListeners();
  }

  /// Resta 10 segundos al temporizador.

  void removeTenSeconds() {
    if (seconds >= 10) {
      seconds -= 10;
    } else {
      if (minutes > 0) {
        minutes--;
        seconds = 50;
      }
    }
    notifyListeners();
  }
}
