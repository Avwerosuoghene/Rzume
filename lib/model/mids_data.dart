import 'dart:core';

class MiscData {
  static final  List<String> _indstryList = [
    "Information Technology",
    "Finance",
    "Healthcare",
    "Manufacturing",
    "Education",
    "Retail",
    "Hospitality",
    "Transportation",
    "Real Estate",
    "Entertainment",
    "Agriculture",
    "Energy",
    "Construction",
    "Telecommunications",
    "Media",
    "Automotive",
    "Fashion",
    "Legal",
    "Consulting",
    "Government"
  ];

  static List<String> getIndustryList() {
    return _indstryList;
  }
}
