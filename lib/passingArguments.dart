import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';


// First Page
class FirstPage extends StatefulWidget {
  FirstPage({super.key, required this.hex});
  Color hex;
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing Space"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("This is the first page"),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondPage()));
              },
              child: const Text("Next page")),
          // color hex output (from second page)
          Text(widget.hex.toString())
        ]),
      ),
    );
  }
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
        // animated container
        // to show color options
        AnimatedContainer(
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

        // selected color hex code as text output
        Text(colorPicker.toString())
      ]),
    );
  }
}

// text style
TextStyle buildPoppinsW500(size) {
  return TextStyle(
      color: Colors.white, fontSize: size, fontWeight: FontWeight.w500);
}
