
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String _coutUrlHead = "https://finicounter.eu.org/counter?host=gongyekepuxinxixitong.x";
const String _coutUrlEnd = "x.project";

Function getViews = ({required String id}) => FutureBuilder(
    future: _fetchData(id),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.done:
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Text('${snapshot.data}',style: const TextStyle(color: Colors.white,shadows: [Shadow(offset: Offset(1,1),blurRadius: 1,color: Colors.black)]),);
          }
        default:
          return const CircularProgressIndicator();
      }
    },
);


Future<String> _fetchData(String id) async {
  var response = await http.get(Uri.parse('$_coutUrlHead$id$_coutUrlEnd'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body)["views"].toString();
  } else {
    return  '?';
  }
}