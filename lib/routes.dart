import 'package:dentist_app/pages/home/home.page.dart';
import 'package:dentist_app/pages/home/search/search.page.dart';
import 'package:flutter/material.dart';

var router = (BuildContext context) => {
      '/': (context) => const HomePage(),
      '/search': (context) => const SearchPage(),
    };
