import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.all(16),
          focusedBorder: TextFormBorders.textFormFocusedBorder,
          enabledBorder: TextFormBorders.textFormEnabledBorder,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _errorMessage = '';
  String seikai = '123456';

  void check() {
    if (_controller.text == seikai) {
      setState(() {
        _errorMessage = '正解です';
      });
    } else {
      setState(() {
        _errorMessage = '違うよ';
        _controller.clear(); // テキストフィールドをリセット
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          children: [
            const SizedBox(width: 32),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PinCodeTextField(
                    controller: _controller,
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    animationType: AnimationType.none,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeColor: Colors.grey,
                      selectedColor: Colors.orange,
                      inactiveColor: Colors.grey,
                      //なんのパラメータ？？
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.grey,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _errorMessage = '';
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage,
                    style: TextStyle(
                      color:
                          _errorMessage == '正解です' ? Colors.orange : Colors.red,
                      //条件式 ? 式1 : 式2 三項演算子
                      //条件式 が true の場合は 式1 が実行
                      //条件式 が false の場合は 式2 が実行
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: check, // check関数を実行する
        child: const Icon(Icons.check),
      ),
    );
  }
}

class TextFormBorders {
  // キーボード表示時のフォームの枠線
  static const textFormFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.deepPurple,
      width: 2,
    ),
  );

  // 平常時のフォームの枠線。
  static const textFormEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  );
}
