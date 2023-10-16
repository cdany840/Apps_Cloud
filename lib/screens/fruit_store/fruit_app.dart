import 'package:flutter/material.dart';
import 'counter.dart';
import 'image_carousel.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class FruitApp extends StatefulWidget {
  const FruitApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FruitApp();
  }
}

class _FruitApp extends State<FruitApp> {
  bool _isFavorited = true;
  double appRating = 3.5;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0, //(79 R,107 G,178 B,255 A)
          backgroundColor: const Color.fromARGB(255, 230, 185, 111), //rgba(230,185,111,255)
          leading: Row(
            children: <Widget>[
              const SizedBox(
                width: 5.0,
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {},
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255,79,107,178), //(79 R,107 G,178 B,255 A)
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const CarouselWithIndicatorDemo(),
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 193, 51, 60), //rgba(193,51,60,255)
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      )),
                  height: 600,
                  width: 500,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Fruta del Diablo',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),                        
                          const SizedBox(
                            height: 20.0,
                          ),
                          const CounterDesign(),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const Text(
                            'Descripción del Producto',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Text(
                            'Las frutas del diablo son unas frutas misteriosas y peculiares '
                            'repartidas por todo el mundo, conocidas por otorgar a sus '
                            'consumidores poderes sobrehumanos permanentes, así como la '
                            'incapacidad de nadar. Con una sola excepción notable, un individuo '
                            'sólo puede adquirir los poderes de una única fruta del diablo y sobrevivir.',
                            textAlign: TextAlign.justify,
                            style:
                                TextStyle(letterSpacing: 2.0, fontSize: 15.0, color:  Colors.white),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(color: Colors.amber),
                                ),
                                height: 70.0,
                                child: SizedBox(
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () { 
                                      setState(() {
                                        _toggleFavorite();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 60, 190, 242), // Background color
                                    ),                                  
                                    child: Icon(                              
                                            _isFavorited
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 33,
                                            color: const Color.fromARGB(255, 238, 209, 76)
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                height: 70.0,
                                minWidth: 260.0,
                                child: SizedBox(
                                  height: 48,
                                  child: ElevatedButton(                            
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 60, 190, 242), // Background color
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Add to cart',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold, color:  Color.fromARGB(255, 238, 209, 76), fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),                              
                            ],
                          ),
                          FlutterRating(
                            size: 40,
                            starCount: 5,
                            rating: appRating,
                            allowHalfRating: true,
                            color: const Color.fromARGB(255, 238, 209, 76),
                            borderColor: const Color.fromARGB(255, 60, 190, 242),
                            mainAxisAlignment: MainAxisAlignment.center,
                            onRatingChanged: (double rating) {
                              setState(() {
                                appRating = rating;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}