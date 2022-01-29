import 'package:flutter/material.dart';
import 'package:qr_code/pages/licenseAgreement.dart';
import 'package:qr_code/requests/http_service.dart';
import 'package:qr_code/validators/valids.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> with TickerProviderStateMixin {
  bool _isLoad = false;
  String? _login;
  String? _password;
  final formKey = GlobalKey<FormState>();

  /*bool visible = true;
  late AnimationController controller;*/
  //bool visiblec = false;

  /* @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: ListView(
            shrinkWrap: true,
            reverse: true,
            children: <Widget>[
              _getHeader(),
              _getInputs(context),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }

  _getHeader() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 100),
          child: Transform.scale(
            scale: 1,
            child: const Image(
                image: AssetImage(
              "assets/images/fvsr-logo.png",
            )),
          )),
    );
  }

  _getInputs(context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: const InputDecoration(
                    hintText: 'Bаш ИД',
                    icon: Icon(
                      Icons.perm_identity,
                      color: Colors.grey,
                    )),
                validator: (initialvalue) =>
                    InputValidators.validateID(initialvalue),
                onSaved: (initialvalue) => _login = initialvalue!.trim(),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: const InputDecoration(
                    hintText: 'Пароль',
                    icon: Icon(
                      Icons.password,
                      color: Colors.grey,
                    )),
                validator: (initialvalue) => initialvalue!.isEmpty
                    ? 'Пароль не может быть пустым'
                    : null,
                onSaved: (initialvalue) => _password = initialvalue!.trim(),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                child: _isLoad
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Вход"),
                onPressed: () async {
                  setState(() => _isLoad = true);
                  final form = formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    await HttpService.getPosts(_login, _password)
                        .then((value) => value.state == true
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LicenseAgreement(
                                        login: _login,
                                        qr: value.body,
                                        fio: value.fio)),
                              )
                        : showDialog(
                        context: this.context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const[
                                  Text("Ошибка",
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                  ),
                                  Icon(Icons.warning_amber_outlined)
                                ],
                              ),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(value.eror,
                                    style: const TextStyle(
                                        fontSize: 20
                                    ),)
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },

                                      child: const Text("Закрыть окно",
                                        style: TextStyle(
                                            fontSize: 20
                                        ),)),
                                ])
                              ],
                        )
                    )
                        // AlertDialog(
                        //     content: Text(value.eror),
                        //     actions: [
                        //       TextButton(
                        //           onPressed: (){
                        //             Navigator.of(context).pop();
                        //           },
                        //           child: Text("Закрыть окно"))
                        //     ],
                        //   )
                            // : showModalBottomSheet(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return Container(
                            //           height: 100,
                            //           color: Colors.redAccent.shade700,
                            //           child: Center(
                            //               child: Column(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   mainAxisSize: MainAxisSize.min,
                            //                   children: <Widget>[
                            //                 Text(value.eror),
                            //                 ElevatedButton(
                            //                     child:
                            //                         const Text('Закрыть окно'),
                            //                     onPressed: () {
                            //                       Navigator.pop(context);
                            //                     })
                            //               ])));
                            //     })
                    );
                  }
                  setState(() => _isLoad = false);
                  // _login = _logController.text;
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  minimumSize: const Size(150, 70),
                  maximumSize: const Size(150, 70),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ));
  }

/* _getSignIn(context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            onPressed: () {
            // _login = _logController.text;
              if (HttpService.getPosts(_login, _password).toString() == 'true') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LicenseAgreement()),
                );
              } else {}
            },
            child: const Text("Вход"),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              minimumSize: const Size(150, 70),
              maximumSize: const Size(150, 70), //////// HERE
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ]
      ),
    );
  }*/
}
