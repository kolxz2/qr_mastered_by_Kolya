import 'package:flutter/material.dart';
import 'package:qr_code/pages/qrCode.dart';
import 'package:qr_code/requests/http_service.dart';
import 'package:flutter/services.dart' show rootBundle;

class LicenseAgreement extends StatefulWidget {
  const LicenseAgreement(
      {Key? key, required this.login, required this.qr, required this.fio})
      : super(key: key);
  final String? login;
  final String? qr;
  final String? fio;

  @override
  State<LicenseAgreement> createState() => _LicenseAgreementState();
}

class _LicenseAgreementState extends State<LicenseAgreement> {
  bool? _agree = false;
  bool _isEnd = false;
  late ScrollController _controller;
  String agriment = '';

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _readRastiska();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Расписка",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[_licenseText(context), _licenseNext()],
        ));
  }

  _licenseNext() {
    // final double end = _scrollController.position.maxScrollExtent;
    return Expanded(
        child: Column(
      children: [
        CheckboxListTile(
            title: const Text(
              "Я ознакомился с правилами",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5),
            ),
            value: _agree,
            activeColor: Colors.blue,
            checkColor: Colors.black38,
            onChanged: (bool? value) {
              if (_isEnd) {
                HttpService.getLicense(widget.login)
                    .then((value) => value == true
                        ? setState(() {
                            _agree = value;
                          })
                        : showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height: 100,
                                  color: Colors.redAccent.shade700,
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                        const Text(
                                            "Нет соединения, проверьте подключение и попробуйте ещё раз!"),
                                        ElevatedButton(
                                          child: const Text('Закрыть окно'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ])));
                            }));
              }
            }),
        ElevatedButton(
          onPressed: _agree!
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QrCode(qr: widget.qr)),
                  );
                }
              : null,
          child: const Text(
            "Вход",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Colors.white,
            shadowColor: Colors.greenAccent,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            minimumSize: const Size(150, 70),
            maximumSize: const Size(150, 70), //////// HERE
          ),
        )
      ],
    ));
  }

  _readRastiska() async {
    String textReaded;
    textReaded = await rootBundle.loadString('assets/text/raspiska.txt');
    setState(() {
      agriment = textReaded;
    });
  }

  _licenseText(context) {
    return Expanded(
        flex: 3,
        child: Scrollbar(
            isAlwaysShown: true,
            child: ListView.builder(
                controller: _controller,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "Я ${widget.fio!} $agriment",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                })));
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _isEnd = true;
      });
    }
  }
}
