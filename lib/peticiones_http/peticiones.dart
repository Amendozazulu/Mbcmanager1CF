import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../widgets_ui/textos.dart';


final dio=Dio();
var datos;
String cliente='';
int estado=0;




  Future ingresar({usuario,pass}) async{
    print (estado);
    var response= await dio.post('https://api.mbcmanager.co/usuarios?login=true&suffix=usuario',
        data:{'usuario':usuario,'pass':pass});
    datos=response.data;
    cliente=(datos['result'] [0] ['nombre']).toString();
    estado=datos['status'];
    print(datos['status']);
    print(datos['result'][0] ['empresa']);
    print(response.data);


  }
















