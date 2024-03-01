import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class PostState extends Equatable{

  final XFile imageFile;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final String imageURL;
  final bool waitingForImageUpload;
  final String? argument;


  const PostState({
    required this.imageFile,
    required this.descriptionController,
    required this.locationController,
    this.imageURL="",
    this.waitingForImageUpload = false,
    this.argument = ""

  });

  @override
  List<Object?> get props => [imageFile, descriptionController, locationController, imageURL,
    waitingForImageUpload, argument];

  PostState copyWith({
    XFile? imageFile,
    TextEditingController? descriptionController,
    TextEditingController? locationController,
    String? imageURL,
    bool? waitingForImageUpload,
    String? argument
  }){
    return PostState(
        imageFile: imageFile ?? this.imageFile,
        descriptionController: descriptionController ?? this.descriptionController,
        locationController: locationController ?? this.locationController,
        imageURL: imageURL ?? this.imageURL,
        waitingForImageUpload: waitingForImageUpload ?? this.waitingForImageUpload,
        argument: argument ?? this.argument
    );
  }

}

