library number_to_string;


import 'dart:ffi';

import 'package:flutter/material.dart';

class NumberToString extends StatelessWidget {

  
  
  var ones = {
    "ar": {
      "_0": "صفر",
      "_1": "واحد",
      "_2": "ٱثنين",
      "_3": "ثلاثة",
      "_4": "أربعة",
      "_5": "خمسة",
      "_6": "ستة",
      "_7": "سبعة",
      "_8": "ثمانية",
      "_9": "تسعة"
    },
  
    "en": {
      "_0": "zero",
      "_1": "one",
      '_2': "two",
      "_3": "three",
      "_4": "for",
      "_5": "five",
      "_6": "six",
      "_7": "seven",
      "_8": "eight",
      "_9": "nine"
    }
  };
  
  var teens = {
    "ar": {
      "_11": "أحد عشر",
      "_12": "أثني عشر",
      "_13": "ثلاثة عشر",
      "_14": "أربعة عشر",
      "_15": "خمسة عشر",
      "_16": "ستة عشر",
      "_17": "سبعة عشر",
      "_18": "ثمانية عشر",
      "_19": "تسعة عشر"
    },
  
    "en": {
      "_11": "eleven",
      "_12": "twelve",
      "_13": "thirteen",
      "_14": "fourteen",
      "_15": "fifteen",
      "_16": "sixteen",
      "_17": "seventeen",
      "_18": "eighteen",
      "_19": "nineteen"
    }
  };
  
  var tens = {
    "ar": {
      "_10": "عشرة",
      "_20": "عشرون",
      "_30": "ثلاثون",
      "_40": "أربعون",
      "_50": "خمسون",
      "_60": "ستون",
      "_70": "سبعون",
      "_80": "ثمانون",
      "_90": "تسعون"
    },
  
    "en": {
      "_10": "ten",
      "_20": "twenty",
      "_30": "thirty",
      "_40": "forty",
      "_50": "fifty",
      "_60": "sixty",
      "_70": "seventy",
      "_80": "eighty",
      "_90": "ninety"
    }
  };
  
  var hundreds = {
    "ar": {
      "_100": "مائة",
      "_200": "مائتين",
      "_300": "ثلاثمائة",
      "_400": "أربعمائة",
      "_500": "خمسمائة",
      "_600": "ستمائة",
      "_700": "سبعمائة",
      "_800": "ثمانمائة",
      "_900": "تسعمائة"
    },
  
    "en": {
      "_100": " hundred",
      "_200": "Two hundred",
      "_300": "Three hundred",
      "_400": "Four hundred",
      "_500": "Five hundred",
      "_600": "Six hundred",
      "_700": "Seven hundred",
      "_800": "Eight hundred",
      "_900": "Nine hundred"
    }
  };
  
  var thousands = {
    "ar": {
      "singular": "ألف",
      "binary": "الفان",
      "plural": "الاف"
    },
  
    "en": {
      "singular": " thousand",
      "binary": "two thousand",
      "plural": "thousands"
    }
  };
  
  var milions = {
    "ar": {
      "singular": " مليون ",
      "binary": "مليونين",
      "plural": "ملايين"
    },
    "en": {
      "singular": " million",
      "binary": "two million",
      "plural": "millions"
    }
  };
  
  var bilions = {
    "ar": {
      "singular": "مليار",
      "binary": "مليارين",
      "plural": "مليارات"
    },
  
    "en": {
      "singular": "one billion",
      "binary": "Two billion",
      "plural": "Billions"
    }
  };
  
  var trilions = {
    "ar": {
      "singular": "ترليون",
      "binary": "ترليونين",
      "plural": "ترليونات"
    },
  
    "en": {
      "singular": "trillion",
      "binary": "Two trillion",
      "plural": "Trillions"
    }
  };
  var columns = ["trilions", "bilions", "milions", "thousands"];
  
  var _digit;
  var prefix = "";
  var suffix = "";
  var _lang;
  var and;
  var getColumnIndex = null;
  dynamic singular = "";
  dynamic decimals = 2;
  dynamic currency;
  
    settings(data) {
 
    singular = data.currency ? data.currency : "";
    decimals = data.decimals ? data.decimals : 2;
    prefix = data.prefix ? data.prefix + " " : "";
    suffix = data.suffix ? " " + data.suffix : "";
  }
  
  parse(number, lang) {
   var _digit = number;
    var columnIndex = _digit.toString().split("").length > 12 ? 0 : 
     _digit.toString().split("").length <= 12 &&  _digit.toString().split("").length > 9 ? 1 : 
      _digit.toString().split("").length <= 9 &&  _digit.toString().split("").length > 6 ? 2 : 
      _digit.toString().split("").length <= 6 && _digit.toString().split("").length >= 3 ? 3 : 0;

    _digit = number;
    _lang = lang;
    if (lang == "ar") {
      and = " و";
    } else {
      and = " ";
    }
  
    List serialized = [];
    var tmp = [];
    var inc = 1;
    var count = _digit.toString().split("").length;
    var column = columnIndex;
    if (count >= 16) {
      throw("Number out of range!");
    
    }
    //Sperate the number into columns
    List rv = _digit.toString().split("")
      .reversed.toList();

      var index = 0;

      rv.forEach((d) {
       
        tmp.add(d);
        if (inc == 3) {
          serialized.insert(0,tmp);
          tmp = [];
          inc = 0;
        }
        
        if (inc == 0 && count - (index + 1) < 3 && count - (index + 1) != 0) {
          serialized.insert(0,tmp);
        }
        inc++;
        index = index+1;
      });



      
  
    // Generate concatenation array
    List<dynamic> concats = new List.generate(columns.length,(i) => i);
    for (int i = columnIndex; i < columns.length; i++) {
      concats[i] =and;
    }

  
    //We do not need some "و"s check last column if 000 drill down until otherwise
    if (_digit > 999) {
      if (int.parse(serialized[serialized.length - 1].join()) == 0) {
        concats[concats.length - 1] = "";
        for (var i = serialized.length - 1; i >= 1; i--) {
          if (int.parse(serialized[i].join("")) == 0) {
            
            concats[i] = "";
          } else {
            break;
          }
        }
        
      }
    }
  
    var str = "";
    str += prefix;
    if (_digit.toString().split("").length >= 1 && _digit.toString().split("").length <= 3) {
      str += read(_digit);
    } else {
      for (var i = 0; i < serialized.length; i++) {
       
        var joinedNumber = int.parse(serialized[i].reversed.toList().join(""));
        
        if (joinedNumber == 0) {
          column++;
          continue;
        }
        if (column == null || column + 1 > columns.length) {
        
          str += read(joinedNumber);
        } else {
         
          str += addSuffixPrefix(serialized[i], column) + concats[column];
        }
        column++;
      }
    }
  
    if (currency != "") {
     
      if (_digit >= 3 && _digit <= 10) {
        str += " " + singular;
      } else {
        str += " " + singular;
      }
  
    }
  
    str += suffix;
    
    return str;
  }
  
    addSuffixPrefix(arr, column) {
      
    
    if (arr.length == 1) {
      if (int.parse(arr[0]) == 1) {
        if(columns[column] == "thousands"){
          return thousands[_lang]!["singular"];
        }else if(columns[column] == "milions"){
          return milions[_lang]!["singular"];
        }else if(columns[column] == "bilions"){
          return bilions[_lang]!["singular"];
        }
        return  trilions[_lang]!["singular"];
      }
      if (int.parse(arr[0]) == 2) {
        if(columns[column] == "thousands"){
          return thousands[_lang]!["binary"];
        }else if(columns[column] == "milions"){
          return milions[_lang]!["binary"];
        }else if(columns[column] == "bilions"){
          return bilions[_lang]!["binary"];
        }
        return  trilions[_lang]!["binary"];
      }
      if (int.parse(arr[0]) > 2 && int.parse(arr[0]) <= 9) {

       
       if(columns[column] == "thousands"){
          return readOnes(int.parse(arr[0])) + " " + thousands[_lang]!["plural"];
        }else if(columns[column] == "milions"){
          return readOnes(int.parse(arr[0])) + " " +  milions[_lang]!["plural"];
        }else if(columns[column] == "bilions"){
          return readOnes(int.parse(arr[0])) + " " +  bilions[_lang]!["plural"];
        }
        return readOnes(int.parse(arr[0])) + " " +  trilions[_lang]!["plural"];

      }
    } else {
      var joinedNumber = int.parse(arr.join(""));
      if (joinedNumber > 1) {

   if(columns[column] == "thousands"){
          return read(joinedNumber) + " " + thousands[_lang]!["singular"];
        }else if(columns[column] == "milions"){
          return read(joinedNumber) + " " +  milions[_lang]!["singular"];
        }else if(columns[column] == "bilions"){
          return read(joinedNumber) + " " +  bilions[_lang]!["singular"];
        }
        return read(joinedNumber) + " " +  trilions[_lang]!["singular"];

      } else {
        if(columns[column] == "thousands"){
          return thousands[_lang]!["singular"];
        }else if(columns[column] == "milions"){
          return milions[_lang]!["singular"];
        }else if(columns[column] == "bilions"){
          return bilions[_lang]!["singular"];
        }
        return  trilions[_lang]!["singular"];
      }
    }
  }
  
  read(d) {
    var str = "";
  
    var len = d.toString().split("").length;
    if (len == 1) {
      str += readOnes(d);
    } else if (len == 2) {
      str += readTens(d);
    } else if (len == 3) {
      str += readHundreds(d);
    }
    return str;
  }
  
  readOnes(d) {
    return ones[_lang]!["_" + d.toString()];
  }
  
   readTens(d) {
    if (d.toString().split("")[1] == "0") {
      return tens[_lang]!["_" + d.toString()];
    }
    if (int.parse(d.toString()) > 10 && int.parse(d.toString()) < 20) {
      return teens[_lang]!["_" + d.toString()];
    }
    if (int.parse(d.toString()) > 19 && int.parse(d.toString()) < 100 && d.toString().split("")[1] != "0") {
      if (_lang == "ar") {
        return (
          readOnes(d.toString().split("")[1]) +
          and +
          tens[_lang]!["_" + d.toString().split("")[0] + "0"]
        );
      } else {
        return (
          tens[_lang]!["_" + d.toString().split("")[0] + "0"]! +
          and +
          readOnes(d.toString().split("")[1])
        );
      }
    }
  }
  
  readHundreds(d) {
    var str = "";
    str += hundreds[_lang]!["_" + d.toString().split("")[0] + "00"]!;
  
    if (
      d.toString().split("")[1] == "0" &&
      d.toString().split("")[2] != "0"
    ) {
      str += and + readOnes(d.toString().split("")[2]);
    }
  
    if (d.toString().split("")[1] != "0") {
      str +=
        and +
        readTens(
          (d.toString().split("")[1] + d.toString().split("")[2]).toString()
        );
    }
    return str;
  }
  
    length() {
    return _digit.toString().split("").length;
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(parse(434,"ar"));
  }
}