import 'package:app_yu_home_front/pages/home.dart';
import 'package:app_yu_home_front/pages/perfil.dart';
import 'package:app_yu_home_front/repository/usuario_repository.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({super.key});

@override
  Widget build(BuildContext context) {
    final UserRepository _usuarioRepostitory = UserRepository();
    TextEditingController _usuario =  TextEditingController();
    TextEditingController _pass =  TextEditingController();

    // TODO: implement build
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.asset('assets/images/UISRAEL.png',
          //  width: 150,
          //  height: 150,
          //),
          SizedBox(
            height: 50,
            width:300,
            child: TextField(
            controller: _usuario,
            decoration: InputDecoration(
              labelText: "Correo",
              border: OutlineInputBorder()
            ),
          )
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 50,
            width:300,  
            child: TextField(
            controller: _pass,
            decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder()
            ),
          ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> Perfil())
                    );
                  }, 
                child: Text("Crear Usuario")),
              Text("/"),
              TextButton(
                onPressed:() async => {
                  if(await _usuarioRepostitory.validarUsuario(_usuario.text, _pass.text))
                  {
                    if(_usuario.text=='Admin')
                    {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=> const Home())
                      )
                    }
                    else
                    {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=> const Home())
                      )
                    } 
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('El usuario no existe'), 
                        duration: Duration(seconds: 2),
                        )
                    )
                  }
                }, 
                child: Text("Iniciar sesion")
                )
            ]
          )
        ],
      )
    );
    
    
  }
}