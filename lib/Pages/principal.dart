import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mbcmanager1/main.dart';
import 'package:mbcmanager1/widgets_ui/textos.dart';




class principal extends StatefulWidget {
  const principal({Key? key}) : super(key: key);

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> {

  List<String>areas=['Cargando......',];
  String currentarea='';
  List <String> equipos=['EDEC01','EDEC02','EDVT01'];
  String currentequipo='';
  List<puntos> varmed=[];
  int campos=1;

  final dio= Dio();

  Future <void> importareas ({String? token}) async{
    try {
      Response response;
      response = await dio.get('https://api.mbcmanager.co/lista_areas_empresas?linkTo=empresa&equalTo=UtopicApps',
      options: Options(
          headers:{
            'Authorization':'Bearer $token'
          }
      )
      );
      campos= response.data['total'];
      print(response.data['result'][0]['area']);



       //areas[0]= response.data['result'][0]['area'];
       areas.add(response.data['result'][1]['area']);


      prueba(campos);
          //data:{'Authorization':'Bearer $token'});
      print(response.data);
      print(token);
    }on DioException catch (e){
      if(e.response!.statusCode!>=400 && e.response!.statusCode!<=500){
       print('error de comunicacion');
      }
    }

  }

  int prueba (int val){
    varmed=[];
    setState(() {
      for (int i = 0; i < val; i++) {
        varmed.add(puntos());

      }

    });

    return val;
  }




  @override
  void initState() {
    super.initState();
    currentarea= areas[0];
    currentequipo=equipos[0];
    importareas(token: token);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /*
      floatingActionButton: FloatingActionButton(
        onPressed: (){importareas(token: token);
          print(token);
          //campos+=1;
          //prueba(campos);
          },
        tooltip: 'descarga de datos',
        child: const Icon(Icons.download),

      ),*/

      body: ListView(
          
        children: <Widget> [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  width: 400.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: const Color(0xff009829),
                      spreadRadius:0.1.r,
                      blurRadius: 10.r,
                    )
                    ]
                  ),
                  child:
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titulosw(texto: 'Home'),
                      
                    ],
                  )
                ),
              const espacios(),
              titulo3(rtext1: 'Bienvenido: ',rtext2:cliente,),
             const espacios(),

             Container(
             width: 300.w,
             height: 200.w,
             padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.w),
             child:Column( children:[
               //Lista desplegable Areas
             DropdownButtonFormField(
               style: TextStyle(fontSize: 20.sp,color: Colors.black,fontFamily: 'MadimiOne'),
               icon: const Icon(Icons.factory_outlined,color: Color(0xff009829) ,),
              decoration: InputDecoration(
                label: Text('Areas',style: TextStyle(fontSize: 20.sp,fontFamily: 'MadimiOne'),),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(width: 3.r,color: Color(0xff009829) )
                )
              ),
              value: currentarea,
                 onChanged: (String? value){
                 if(value!=null && currentarea!=value){

                 setState(() {
                 currentarea=value;

                 });
               }
                 },

                 items: areas.map((String areas)=>
                  DropdownMenuItem(value:areas,child: Text(areas))).toList()),

                const espacios(),
                const espacios(),
                //Lista desplegable equipos

               DropdownButtonFormField(
                   style: TextStyle(fontSize: 20.sp,color: Colors.black,fontFamily: 'MadimiOne'),
                   icon: const Icon(Icons.construction_sharp,color: Color(0xff009829) ,),
                   decoration: InputDecoration(
                       label: Text('Equipos',style: TextStyle(fontSize: 20.sp,fontFamily: 'MadimiOne'),),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(30.r),
                           borderSide: BorderSide(width: 3.r,color: const Color(0xff009829) )
                       )
                   ),
                   value: currentequipo,
                   onChanged: (String? value){
                     if(value!=null && currentequipo!=value){

                       setState(() {
                         currentequipo=value;

                       });
                     }
                   },

                   items: equipos.map((String areas)=>
                       DropdownMenuItem(value:areas,child: Text(areas))).toList()),

             ]),

             ),
                //const espacios(),
                const escrib(text: 'Ingreso de medidas :'),
                const espacios(),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.w),
                  width: 300.w,
                  height: 250.w,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: const Color(0xff009829),
                      spreadRadius: 0.1.r,
                      blurRadius: 10.r,
                    )],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r)

                  ),
                  child:

                      ListView.builder(
                        //scrollDirection: Axis.vertical,
                        //shrinkWrap: true,

                        itemCount: prueba(campos) ,
                        itemBuilder: (BuildContext context,int index)
                        {
                          return
                            Column(
                                children:[
                                  // Text('Enviar medidas',style: TextStyle(fontSize: 20),),

                                  TextField(
                                    controller: varmed[index].val1,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                                        hintText: '${index+1} HV ',
                                        prefixIcon: Icon(Icons.settings_remote),
                                        border:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        )
                                    ),
                                  ),

                                  TextField(
                                    controller: varmed[index].val2,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                                        hintText: '${index+1} HAB ',
                                        prefixIcon: Icon(Icons.settings_remote),
                                        border:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        )
                                    ),
                                  ),

                                  TextField(
                                    controller: varmed[index].val3,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                                        hintText: '${index+1} HAA ',
                                        prefixIcon: Icon(Icons.settings_remote),
                                        border:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        )
                                    ),
                                  ),

                                  TextField(
                                    controller: varmed[index].val4,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                                        hintText: '${index+1} HVV ',
                                        prefixIcon: Icon(Icons.settings_remote),
                                        border:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        )
                                    ),
                                  ),

                                  TextField(
                                    controller: varmed[index].val5,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(color: Colors.white,fontSize: 20),
                                        hintText: '${index+1} HAV' ,
                                        prefixIcon: Icon(Icons.settings_remote),
                                        border:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        )
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                ]
                            );
                          //SizedBox(height: 20);

                        },

                      ),



                ),
                const espacios(),
                ElevatedButton(onPressed: (){
                  print('envio de datos');
                  campos-=1;
                  prueba(campos);
                  },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 35.w,vertical: 15.w),
                      shadowColor: const Color(0xff009829),
                      elevation: 5,
                    ),

                    child: Text('Enviar datos',style: TextStyle(fontSize: 20.sp,fontFamily: 'MadimiOne')),

                ) ],
              
            )
          )
          
        ],


          
      ),




    );
  }
}
