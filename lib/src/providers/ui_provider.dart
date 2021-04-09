

import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{

  int _selectedMenuOpt = 1;

  int get selectedMenuOpt{
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int i){
    this._selectedMenuOpt = i;
    //Notificamos a todos los widgets oyentes del cambio ralizado
    //a traves de la siguiente funcion, de la cual la obtendemos de la extencion de ChangeNotifier

    notifyListeners();

  }

}