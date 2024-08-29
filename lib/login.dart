import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PrecoBit extends StatefulWidget {
  const PrecoBit({super.key});

  @override
  State<PrecoBit> createState() => _PrecoBitState();
}

class _PrecoBitState extends State<PrecoBit> {
  String _preco = '0.00';

  void _recuperarPreco() async {
    String url = 'https://blockchain.info/ticker';
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = jsonDecode(response.body);
    setState(() {
      _preco = retorno['BRL']['buy'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('imagens/bitcoin.png'),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  'R\$ $_preco',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: _recuperarPreco,
                child: Text('Atualizar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
