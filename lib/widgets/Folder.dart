import "package:flutter/material.dart";

class Folder {
  String name;
  Folder? superFolder;
  List<Folder> subfolders;
  List<String> documents;

  Folder(
      {List<Folder>? subfolders,
      List<String>? documents,
      this.name = "untitled folder",
      this.superFolder})
      : this.subfolders = subfolders ?? [],
        this.documents = documents ?? [];

  bool checkDuplicateName(String name) {
    for (var i = 0; i < subfolders.length; i++) {
      if (subfolders[i].name == name) {
        return true;
      }
    }
    return false;
  }

  bool isEmpty() {
    if (this.subfolders.length + this.documents.length == 0) {
      return true;
    }
    return false;
  }
}
