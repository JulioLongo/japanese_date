import 'dart:math';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _textoDia;
  DateTime? _dataSelecionada;
  bool _exibirTextoDia = false;

  void _atualizarTextoDia() {
    if (_dataSelecionada != null) {
      String diaDaSemana = diaDaSemanaEmHiragana(_dataSelecionada!.weekday);
      String ano = '${numeroParaHiragana(_dataSelecionada!.year)}ねん';
      String mes = mesParaHiragana(_dataSelecionada!.month);
      String dia = diaParaHiragana(_dataSelecionada!.day);

      _textoDia = '$diaDaSemana\n\n$ano, $mes, $dia';
    }
  }

  void _sortearData() {
    int ano = Random().nextInt(201) + 1900; // Ano entre 1900 e 2100
    int mes = Random().nextInt(12) + 1; // Mês entre 1 e 12
    int dia = Random().nextInt(DateTime(ano, mes + 1, 0).day) +
        1; // Dia válido para o mês e ano
    setState(() {
      _dataSelecionada = DateTime(ano, mes, dia);
      _exibirTextoDia = false;
      _atualizarTextoDia();
    });
  }

  void _definirDataDeHoje() {
    setState(() {
      _dataSelecionada = DateTime.now();
      _exibirTextoDia = false;
      _atualizarTextoDia();
    });
  }

  String diaDaSemanaEmHiragana(int dia) {
    switch (dia) {
      case 1:
        return 'げつようび'; // Segunda-feira
      case 2:
        return 'かようび'; // Terça-feira
      case 3:
        return 'すいようび'; // Quarta-feira
      case 4:
        return 'もくようび'; // Quinta-feira
      case 5:
        return 'きんようび'; // Sexta-feira
      case 6:
        return 'どようび'; // Sábado
      case 7:
        return 'にちようび'; // Domingo
      default:
        return 'ひむこう'; // Dia inválido
    }
  }

  String numeroParaHiragana(int numero) {
    final numeros = {
      0: 'ゼロ',
      1: 'いち',
      2: 'に',
      3: 'さん',
      4: 'よん',
      5: 'ご',
      6: 'ろく',
      7: 'なな',
      8: 'はち',
      9: 'きゅう',
      10: 'じゅう',
      100: 'ひゃく',
      300: 'さんびゃく',
      600: 'ろっぴゃく',
      800: 'はっぴゃく',
      1000: 'せん',
      3000: 'さんぜん',
      8000: 'はっせん',
      10000: 'まん'
    };

    if (numeros.containsKey(numero)) {
      return numeros[numero]!;
    }

    if (numero < 100) {
      int dezenas = numero ~/ 10;
      int unidades = numero % 10;
      if (unidades == 0) {
        return '${numeros[dezenas]!}${numeros[10]!}';
      }
      return '${numeros[dezenas]!}${numeros[10]!}${numeros[unidades]!}';
    }

    if (numero < 1000) {
      int centenas = numero ~/ 100;
      int resto = numero % 100;
      if (resto == 0) {
        return '${numeros[centenas * 100] ?? "${numeros[centenas]}${numeros[100]}"}';
      }
      return '${numeros[centenas * 100] ?? "${numeros[centenas]}${numeros[100]}"}${numeroParaHiragana(resto)}';
    }

    if (numero < 2000) {
      int resto = numero % 1000;
      return '${numeros[1000]!}${numeroParaHiragana(resto)}';
    }

    if (numero < 10000) {
      int milhares = numero ~/ 1000;
      int resto = numero % 1000;
      if (resto == 0) {
        return '${numeros[milhares]!}${numeros[1000]!}';
      }
      return '${numeros[milhares]!}${numeros[1000]!}${numeroParaHiragana(resto)}';
    }

    return 'Número grande demais';
  }

  String mesParaHiragana(int mes) {
    final meses = {
      1: 'いちがつ',
      2: 'にがつ',
      3: 'さんがつ',
      4: 'しがつ',
      5: 'ごがつ',
      6: 'ろくがつ',
      7: 'しちがつ',
      8: 'はちがつ',
      9: 'くがつ',
      10: 'じゅうがつ',
      11: 'じゅういちがつ',
      12: 'じゅうにがつ'
    };

    return meses[mes] ?? 'Mês inválido';
  }

  final List<String> diasDaSemanaEmIngles = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  String diaParaHiragana(int dia) {
    switch (dia) {
      case 1:
        return 'ついたち';
      case 2:
        return 'ふつか';
      case 3:
        return 'みっか';
      case 4:
        return 'よっか';
      case 5:
        return 'いつか';
      case 6:
        return 'むいか';
      case 7:
        return 'なのか';
      case 8:
        return 'ようか';
      case 9:
        return 'ここのか';
      case 10:
        return 'とおか';
      case 14:
        return 'じゅうよっか';
      case 20:
        return 'はつか';
      case 24:
        return 'にじゅうよっか';
      case 17:
        return 'じゅうしちにち'; // ou 'じゅうななにち'
      case 27:
        return 'にじゅうしちにち'; // ou 'にじゅうななにち'
      default:
        if (dia > 10 && dia < 32) {
          return numeroParaHiragana(dia) + 'にち';
        }
        return 'Dia inválido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Center(
            child: Text(
              'きょうはなんにちですか',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          if (_textoDia != null )
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '${_dataSelecionada?.year ?? DateTime.now().year}/${(_dataSelecionada?.month ?? DateTime.now().month).toString().padLeft(2, '0')}/${(_dataSelecionada?.day ?? DateTime.now().day).toString().padLeft(2, '0')} - ${diasDaSemanaEmIngles[(_dataSelecionada?.weekday ?? DateTime.now().weekday) - 1]}',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          if (_textoDia != null && _exibirTextoDia)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                _textoDia!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _definirDataDeHoje,
                  child: Text('Data de Hoje'),
                ),
                SizedBox(width: 10), //
                ElevatedButton(
                  onPressed: _sortearData,
                  child: Text('Sortear Data'),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(height: 16),
          if (_textoDia != null)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _exibirTextoDia = true;
                });
              },
              child: Text('Show'),
            ),
        ],
      ),
    );
  }
}
