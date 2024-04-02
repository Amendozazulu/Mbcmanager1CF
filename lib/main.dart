import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mbcmanager1/Pages/principal.dart';
import 'package:mbcmanager1/widgets_ui/textos.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

String? nombre;
final dio=Dio();
String cliente='';
String token='';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(370,750),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_,child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          //title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff009829)),
            useMaterial3: true,
          ),
          home: MyHomePage(),
        );
      }

    );


  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController usuario=TextEditingController();
  TextEditingController contrasena=TextEditingController();
  bool boton=true;
  String prueba='';
  var datos;
  bool _circularprog=true;
  //bool seg=true;



  Future <void> ingresar({usuario1,pass}) async{

    try {
      Response response;
      response = await dio.post(
          'https://api.mbcmanager.co/usuarios?login=true&suffix=usuario',
          data: {'usuario': usuario1, 'pass': pass});
      datos = response.data;
      print(usuario1);
      cliente = (datos['result'] [0] ['nombre']).toString();
      print(datos['status']);
      print(datos['result'][0] ['token']);
      print(response.data);

      if (datos['status'] == 200) {
        setState(() {
          _circularprog=!_circularprog;
          print(_circularprog);
        });

        cliente = datos['result'][0] ['nombre'];
        token = datos['result'][0] ['token'];
        usuario.text = '';
        contrasena.text = '';
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => principal()));
      }
    } on DioException catch (e){
      if (e.response!.statusCode!>=400 && e.response!.statusCode!<=599)
        {
          setState(() {
            _circularprog=!_circularprog;
            print(_circularprog);
          });

          showDialog(context: context, builder: (BuildContext context){
           return const AlertDialog( title: escrib(text: 'Usuario o contraseña incorrectos, verificar:\n'
               '- Usuario \n -Contraseña \n -Conexion a Internet '));
             }

          );

          print('error en informacion');
        }

    }


    /*
    try {
      await dio.post('https://api.mbcmanager.co/usuarios?login=true&suffix=usuario',
          data:{'usuario':usuario1,'pass':pass});
    } on DioException catch (e){
      if (e.response!.statusCode!>=400 && e.response!.statusCode!<=599)
        {
          print('error en informacion');
          print(response.data);
          print(response.headers);
        }else {
        print(e.requestOptions);
        print(e.message);
      }

    }
   */

  }



  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      body: ListView(

        children: <Widget>[
            Center(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(height: 300.w,width: 400.w,
                  decoration:  BoxDecoration(
                    boxShadow: [BoxShadow(
                      color:const Color(0xff009829),
                      spreadRadius: 0.1.r,
                      blurRadius: 10.r,
                    )

                    ],
                    color:Color(0xff009829),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40).w,
                    bottomRight: Radius.circular(40).w)
                  ),
                  child:
                   Column(
                   children:<Widget>[
                      SizedBox(height: 10.w,),
                     const titulosw(texto: 'MBC Manager'),
                     Image(image: const  AssetImage('assets/images/logotipo.png'),
                     height: 150.w,
                     width: 150.w,),
                      const espacios(),
                      const titulow(texto:'Inicio Usuario'),
                  ]),),

                  const espacios(),

                  Container(width: 300.w,height: 250.w,
                    padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical:15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20).w,
                    boxShadow:  [
                    BoxShadow(
                    color: const Color(0xff009829),
                    spreadRadius: 0.1.r,
                    blurRadius: 5.r )],),

                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(
                            width: 300.w,
                            height: 90.w,
                          child: TextField(controller: usuario,

                          maxLength: 10,
                              style: TextStyle(fontSize: 18.sp,fontFamily:'MadimiOne' ),
                              keyboardType: TextInputType.text,
                              cursorColor:Color(0xff009829),
                              cursorOpacityAnimates: true,
                              decoration: InputDecoration(
                                helperText: 'Usuario',
                                label: Text('Usuario',style: TextStyle(fontFamily: 'MadimiOne',fontSize: 18.sp),),
                                prefixIcon: Icon(Icons.engineering_outlined,color:Color(0xff009829),size: 25.w ,),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:Color(0xff009829),width: 3.w ),
                                  borderRadius: BorderRadius.circular(30).w,
                                )
                              ),),),
                          const espacios(),
                           SizedBox(
                            width: 300.w,
                            height: 90.w,
                          child: TextField(controller: contrasena,
                            style: TextStyle(fontSize: 18.sp,fontFamily:'MadimiOne' ),
                            maxLength: 10,
                            keyboardType: TextInputType.text,
                            cursorColor: const Color(0xff009829),
                            cursorOpacityAnimates: true,
                            obscureText: boton,
                            decoration: InputDecoration(

                                helperText: 'Contraseña',
                                label: Text('Contraseña',style: TextStyle(fontFamily: 'MadimiOne',fontSize: 18.sp )),
                                prefixIcon: Icon(Icons.password,color: Color(0xff009829),size: 25.w,),
                                suffixIcon: IconButton(onPressed: (){setState(() {
                                  boton=!boton;
                                });},
                                icon: boton? Icon(Icons.visibility_off_outlined,size: 25.w,): Icon(Icons.visibility_outlined,size:25.w),),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(color:const Color(0xff009829),width: 3.w ),
                                  borderRadius: BorderRadius.circular(30).w,
                                )
                            ),),),

                        ],

                      ),

                  ),
                  const espacios(),


                  ElevatedButton(onPressed: () {
                      print(_circularprog);
                    if (contrasena.text.toString()==''){
                      showDialog(context: context, builder: (BuildContext context){
                        return const AlertDialog(
                          title: escrib(text:'Por favor ingresar su Contraseña'),
                        );

                      });

                    }

                    if (usuario.text.toString()=='')
                      {
                        showDialog(context: context, builder: (BuildContext context){
                          return  const AlertDialog(
                            title:  escrib(text: 'Por favor ingresar su Usuario',
                            ),
                          );
                        });
                      }

                    if(usuario.text.toString()!=''&& contrasena.text.toString()!=''){
                      ingresar(usuario1:usuario.text.toString(),pass:contrasena.text.toString());
                      print(_circularprog);
                    showDialog(context: context, builder: (context){
                      return Center(child:SizedBox(
                        width: 100.w,
                          height: 100.h,
                          child: _circularprog? const CircularProgressIndicator(strokeWidth: 10,):
                      const CircularProgressIndicator(strokeWidth: 10,value:0.0)));
                    });
                  }



                    },


                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 35.w,vertical: 15.w),
                        shadowColor: const Color(0xff009829),
                        elevation: 5,
                      ),
                      child: Text('Ingresar',style: TextStyle(fontSize: 20.sp,fontFamily: 'MadimiOne'),)),

                  SizedBox(height: 100.w,),



                  const Text('Power by Andres Mendoza')
                ],

              )

            )

          ],

      ),

    );
  }
}
