import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class titulosw extends StatelessWidget {
  const titulosw({Key? key,required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(texto,style: TextStyle(color:Colors.white,fontSize: 35.sp,
        fontWeight:FontWeight.w900,fontFamily: 'RussoOne' ));
  }
}

class titulow extends StatelessWidget {
  const titulow({Key? key,required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(texto,style: TextStyle(color:Colors.white,fontSize: 25.sp,
        fontWeight:FontWeight.w900,fontFamily: 'RussoOne',letterSpacing: 3 ));
  }
}

class escrib extends StatelessWidget {
  const escrib({Key? key,required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return  Text(text,style: TextStyle(color:Colors.black,fontSize: 23.sp,fontFamily: 'MadimiOne'),);
  }
}

class titulo3 extends StatelessWidget {
  const titulo3({Key? key,required this.rtext1,required this.rtext2});
  final String rtext1;
  final String rtext2;

  @override
  Widget build(BuildContext context) {
    return RichText(text:
    TextSpan(
        text: rtext1,
        style:  TextStyle(color:Color(0xff009829),
            fontSize: 30.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'RussoOne'
        ),
        children: [
          TextSpan(text:rtext2,
              style:  TextStyle(
                  color:Colors.black,
                  letterSpacing: 3.sp,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MadimiOne'))
        ]
    ));
  }
}



class espacios extends StatelessWidget {
  const espacios({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 20.w,);
  }
}

class puntos{
  final TextEditingController HV= TextEditingController();
  final TextEditingController HAB=TextEditingController();
  final TextEditingController HAA=TextEditingController();
  final TextEditingController HVV= TextEditingController();
  final TextEditingController HAV= TextEditingController();

  TextEditingController get val1 => HV;
  TextEditingController get val2 => HAB;
  TextEditingController get val3 => HAA;
  TextEditingController get val4 => HVV;
  TextEditingController get val5 => HAV;



}
