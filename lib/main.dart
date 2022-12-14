import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing space',
      // home: MyHomePage(),
      routes: {
        '/': (context) => FirstPage(
              hex: const Color(0xff443a49),
            ),
        '/second': (context) => const SecondPage()
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({super.key, required this.hex});
  Color hex;
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    // Color code = hex;
    Color result = const Color(0xff443a49);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing Space"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("This is the first page"),
          const SizedBox(height: 50),
          ElevatedButton(
              // onPressed: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const SecondPage()));
              // },
              onPressed: () {
                var result = _navigateAndDisplaySelection(context);
              },
              child: const Text("Next page")),
          Text(result.toString())
        ]),
      ),
    );
  }
}

// FUTURE ROUTE
Future<void> _navigateAndDisplaySelection(BuildContext context) async {
  final Color result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SecondPage()),
  );

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(result.toString())));
}

// Second Page
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  bool color = false;
  Color colorPicker = const Color(0xff443a49);
  late AnimationController _animateController;

  void changeColor(Color color) {
    setState(() {
      colorPicker = color;
    });
  }

  @override
  void initState() {
    _animateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    super.initState();
  }

  void _handOnPressed() {
    setState(() {
      color = !color;
      color ? _animateController.forward() : _animateController.reverse();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: colorPicker,
          onPressed: () {
            Navigator.pop(context, colorPicker);
          },
        ),
        title: const Text("Second Page"),
      ),
      body: Column(children: [
        AnimatedContainer(
          // margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          width: 400,
          height: color == false ? 70 : 280,
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      // color text
                      child: Text("COLOR :",
                          style: GoogleFonts.poppins(
                            textStyle: buildPoppinsW500(16.0),
                          )),
                    ),
                    const Spacer(),
                    // color show case
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 30,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorPicker,
                      ),
                    ),
                    const Spacer(),
                    // animated button menu - arrow
                    IconButton(
                      onPressed: () {
                        _handOnPressed();
                      },
                      icon: AnimatedIcon(
                          icon: AnimatedIcons.menu_arrow,
                          color: Colors.white,
                          progress: _animateController),
                      // splashColor: Colors.transparent,
                    )
                  ],
                ),
                // Color Drop Down Menu
                color == true
                    ? SizedBox(
                        height: 200,
                        child: MaterialPicker(
                          pickerColor: colorPicker,
                          onColorChanged: changeColor,
                          enableLabel: true,
                          portraitOnly: true,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Text(colorPicker.toString())
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, colorPicker);
            },
            child: Text(colorPicker.toString()))
      ]),
    );
  }
}

TextStyle buildPoppinsW500(size) {
  return TextStyle(
      color: Colors.white, fontSize: size, fontWeight: FontWeight.w500);
}
