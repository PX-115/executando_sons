import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AudioPlayer audioPlayer = new AudioPlayer();
  AudioCache audioCache = new AudioCache(prefix: "audios/");
  bool _primeiraExecucao = true;
  double _volume = 0.5;

  _executar() async {
    audioPlayer.setVolume(_volume);
    
    if(_primeiraExecucao){
      audioPlayer = await audioCache.play("sfa-character-select.mp3");
      _primeiraExecucao = false;
    } else {
      audioPlayer.resume();
    }
    //int resultado = await audioPlayer.play(localPath, isLocal: true);

    /*
    String url = "https://vgmsite.com/soundtracks/street-fighter-alpha-2-1996-sega-saturn-gamerip/opdcxxkxwt/06.mp3";
    int resultado = await audioPlayer.play(url);
   
    if (resultado == 1){
      // success
      print("Resultado = Sucesso");
    } else {
      print("Resultado = Erro");
    }
    */
  }

  _pausar() async {
    int resultado = await audioPlayer.pause();
  }

  _parar() async {
    int resultado = await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Executando sons"),
        backgroundColor: Colors.green,
      ),

      body: Column(
        children: <Widget>[
          Slider(
            value: _volume,
            min: 0,
            max: 1,
            onChanged: (novoVolume){
              setState(() {
                _volume = novoVolume;                
              });
              audioPlayer.setVolume(novoVolume);
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/executar.png"),
                  //child: Icon(Icons.play_arrow, size: 60,),
                  onTap: (){
                    _executar();
                  },
                )
              ),

              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/pausar.png"),
                  //child: Icon(Icons.pause, size: 60,),
                  onTap: (){
                    _pausar();
                  },
                )
              ),

              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/imagens/parar.png"),
                  //child: Icon(Icons.stop, size: 60,),
                  onTap: (){
                    _parar();
                  },
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}